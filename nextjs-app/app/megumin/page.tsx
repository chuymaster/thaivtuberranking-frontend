'use client';

import { useState, useEffect, useCallback } from 'react';
import { User, signInWithPopup, signOut, onAuthStateChanged } from 'firebase/auth';
import { auth, googleProvider } from '@/lib/firebase/config';
import { 
  getChannelRequests, 
  updateChannelRequest, 
  deleteChannelRequest,
  addChannel 
} from '@/lib/api/admin';
import { 
  ChannelRequest, 
  ChannelRequestStatus, 
  ChannelType,
  channelTypeLabel,
  channelStatusLabel,
  channelStatusColor
} from '@/lib/types/admin';
import { SafeImage } from '@/components/ui/SafeImage';

type Tab = 'requests' | 'management';

export default function AdminPage() {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [activeTab, setActiveTab] = useState<Tab>('requests');
  
  // Channel Requests state
  const [requests, setRequests] = useState<ChannelRequest[]>([]);
  const [requestsLoading, setRequestsLoading] = useState(false);
  const [requestsError, setRequestsError] = useState<string | null>(null);

  useEffect(() => {
    const unsubscribe = onAuthStateChanged(auth, (user) => {
      setUser(user);
      setLoading(false);
    });
    return () => unsubscribe();
  }, []);

  const handleSignIn = async () => {
    try {
      await signInWithPopup(auth, googleProvider);
    } catch (error) {
      console.error('Sign in error:', error);
    }
  };

  const handleSignOut = async () => {
    try {
      await signOut(auth);
    } catch (error) {
      console.error('Sign out error:', error);
    }
  };

  const fetchRequests = useCallback(async () => {
    if (!user) return;
    
    setRequestsLoading(true);
    setRequestsError(null);
    
    try {
      const token = await user.getIdToken();
      const data = await getChannelRequests(token);
      setRequests(data);
    } catch (error) {
      setRequestsError(error instanceof Error ? error.message : 'Failed to fetch requests');
    } finally {
      setRequestsLoading(false);
    }
  }, [user]);

  useEffect(() => {
    if (user && activeTab === 'requests') {
      fetchRequests();
    }
  }, [user, activeTab, fetchRequests]);

  const handleUpdateStatus = async (request: ChannelRequest, newStatus: ChannelRequestStatus) => {
    if (!user) return;
    
    try {
      const token = await user.getIdToken();
      await updateChannelRequest(token, request.channel_id, request.type, newStatus);
      
      // If accepted, also add to channel list
      if (newStatus === ChannelRequestStatus.Accepted) {
        await addChannel(token, request.channel_id, request.title, request.thumbnail_image_url, request.type);
      }
      
      // Refresh the list
      fetchRequests();
    } catch (error) {
      alert(error instanceof Error ? error.message : 'Failed to update status');
    }
  };

  const handleDelete = async (channelId: string) => {
    if (!user) return;
    if (!confirm('Are you sure you want to delete this request?')) return;
    
    try {
      const token = await user.getIdToken();
      await deleteChannelRequest(token, channelId);
      fetchRequests();
    } catch (error) {
      alert(error instanceof Error ? error.message : 'Failed to delete request');
    }
  };

  const handleChangeType = async (request: ChannelRequest, newType: ChannelType) => {
    if (!user) return;
    
    try {
      const token = await user.getIdToken();
      await updateChannelRequest(token, request.channel_id, newType, request.status);
      fetchRequests();
    } catch (error) {
      alert(error instanceof Error ? error.message : 'Failed to update type');
    }
  };

  if (loading) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="animate-spin h-8 w-8 border-4 border-blue-500 border-t-transparent rounded-full" />
      </div>
    );
  }

  if (!user) {
    return (
      <div className="min-h-screen flex items-center justify-center bg-gray-100">
        <div className="bg-white p-8 rounded-lg shadow-md text-center max-w-md">
          <h1 className="text-2xl font-bold text-gray-900 mb-4">Admin Login</h1>
          <p className="text-gray-600 mb-6">Access is limited to authorized personnel only. 💥</p>
          <button
            onClick={handleSignIn}
            className="flex items-center justify-center gap-3 w-full px-4 py-3 bg-white border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
          >
            <svg className="w-5 h-5" viewBox="0 0 24 24">
              <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
              <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
              <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
              <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
            </svg>
            <span className="text-gray-700 font-medium">Sign in with Google</span>
          </button>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-100">
      {/* Header */}
      <header className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 py-4 flex items-center justify-between">
          <h1 className="text-xl font-bold text-gray-900">Admin Panel 💥</h1>
          <div className="flex items-center gap-4">
            <span className="text-sm text-gray-600">{user.email}</span>
            <button
              onClick={handleSignOut}
              className="px-3 py-1.5 text-sm text-gray-600 hover:text-gray-900 hover:bg-gray-100 rounded"
            >
              Logout
            </button>
          </div>
        </div>
      </header>

      {/* Tabs */}
      <div className="max-w-7xl mx-auto px-4 pt-4">
        <div className="border-b border-gray-200">
          <nav className="flex gap-4">
            <button
              onClick={() => setActiveTab('requests')}
              className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
                activeTab === 'requests'
                  ? 'border-blue-500 text-blue-600'
                  : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}
            >
              Channel Requests
            </button>
            <button
              onClick={() => setActiveTab('management')}
              className={`px-4 py-2 text-sm font-medium border-b-2 transition-colors ${
                activeTab === 'management'
                  ? 'border-blue-500 text-blue-600'
                  : 'border-transparent text-gray-500 hover:text-gray-700'
              }`}
            >
              Channel Management
            </button>
          </nav>
        </div>
      </div>

      {/* Content */}
      <div className="max-w-7xl mx-auto px-4 py-6">
        {activeTab === 'requests' && (
          <div className="bg-white rounded-lg shadow">
            {/* Toolbar */}
            <div className="p-4 border-b border-gray-200 flex items-center justify-between">
              <h2 className="font-semibold text-gray-900">Channel Requests ({requests.length})</h2>
              <button
                onClick={fetchRequests}
                disabled={requestsLoading}
                className="px-3 py-1.5 text-sm bg-blue-500 text-white rounded hover:bg-blue-600 disabled:opacity-50"
              >
                {requestsLoading ? 'Loading...' : 'Refresh'}
              </button>
            </div>

            {/* Error */}
            {requestsError && (
              <div className="p-4 bg-red-50 text-red-700 text-sm">
                {requestsError}
              </div>
            )}

            {/* Table */}
            <div className="overflow-x-auto">
              <table className="w-full">
                <thead className="bg-gray-50">
                  <tr>
                    <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Channel</th>
                    <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Type</th>
                    <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
                    <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Updated</th>
                    <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                  </tr>
                </thead>
                <tbody className="divide-y divide-gray-200">
                  {requests.map((request) => (
                    <tr key={request.channel_id} className="hover:bg-gray-50">
                      <td className="px-4 py-3">
                        <a
                          href={`https://youtube.com/channel/${request.channel_id}`}
                          target="_blank"
                          rel="noopener noreferrer"
                          className="flex items-center gap-3 hover:text-blue-600"
                        >
                          <SafeImage
                            src={request.thumbnail_image_url}
                            alt={request.title}
                            width={40}
                            height={40}
                            className="rounded-full"
                          />
                          <div>
                            <div className="font-medium text-gray-900 text-sm">{request.title}</div>
                            <div className="text-xs text-gray-500">{request.channel_id}</div>
                          </div>
                        </a>
                      </td>
                      <td className="px-4 py-3">
                        <select
                          value={request.type}
                          onChange={(e) => handleChangeType(request, Number(e.target.value) as ChannelType)}
                          className="text-sm border-2 border-blue-500 rounded px-2 py-1 bg-white text-gray-900 font-medium"
                        >
                          <option value={ChannelType.Original}>{channelTypeLabel(ChannelType.Original)}</option>
                          <option value={ChannelType.Half}>{channelTypeLabel(ChannelType.Half)}</option>
                        </select>
                      </td>
                      <td className="px-4 py-3">
                        <span className={`inline-block px-2 py-1 text-xs font-medium rounded ${channelStatusColor(request.status)}`}>
                          {channelStatusLabel(request.status)}
                        </span>
                      </td>
                      <td className="px-4 py-3 text-sm text-gray-500">
                        {new Date(request.updated_at).toLocaleString()}
                      </td>
                      <td className="px-4 py-3">
                        <div className="flex items-center gap-2">
                          {request.status === ChannelRequestStatus.Unconfirmed && (
                            <>
                              <button
                                onClick={() => handleUpdateStatus(request, ChannelRequestStatus.Accepted)}
                                className="px-2 py-1 text-xs bg-green-500 text-white rounded hover:bg-green-600"
                              >
                                Accept
                              </button>
                              <button
                                onClick={() => handleUpdateStatus(request, ChannelRequestStatus.Pending)}
                                className="px-2 py-1 text-xs bg-blue-500 text-white rounded hover:bg-blue-600"
                              >
                                Pending
                              </button>
                              <button
                                onClick={() => handleUpdateStatus(request, ChannelRequestStatus.Rejected)}
                                className="px-2 py-1 text-xs bg-red-500 text-white rounded hover:bg-red-600"
                              >
                                Reject
                              </button>
                            </>
                          )}
                          <button
                            onClick={() => handleDelete(request.channel_id)}
                            className="px-2 py-1 text-xs bg-gray-200 text-gray-700 rounded hover:bg-gray-300"
                          >
                            Delete
                          </button>
                        </div>
                      </td>
                    </tr>
                  ))}
                  {requests.length === 0 && !requestsLoading && (
                    <tr>
                      <td colSpan={5} className="px-4 py-8 text-center text-gray-500">
                        No channel requests found
                      </td>
                    </tr>
                  )}
                </tbody>
              </table>
            </div>
          </div>
        )}

        {activeTab === 'management' && (
          <div className="bg-white rounded-lg shadow p-8 text-center text-gray-500">
            Channel Management - Coming soon 💥
          </div>
        )}
      </div>
    </div>
  );
}
