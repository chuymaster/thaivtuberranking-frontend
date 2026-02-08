export enum ChannelType {
  Original = 1,
  Half = 2,
}

export enum ChannelRequestStatus {
  Unconfirmed = 1,
  Accepted = 2,
  Pending = 3,
  Rejected = 4,
}

export interface ChannelRequest {
  channel_id: string;
  title: string;
  thumbnail_image_url: string;
  type: ChannelType;
  status: ChannelRequestStatus;
  updated_at: number;
}

export const channelTypeLabel = (type: ChannelType): string => {
  switch (type) {
    case ChannelType.Original:
      return 'Original VTuber';
    case ChannelType.Half:
      return 'All VTuber';
  }
};

export const channelStatusLabel = (status: ChannelRequestStatus): string => {
  switch (status) {
    case ChannelRequestStatus.Unconfirmed:
      return 'Unconfirmed';
    case ChannelRequestStatus.Accepted:
      return 'Accepted';
    case ChannelRequestStatus.Pending:
      return 'Pending';
    case ChannelRequestStatus.Rejected:
      return 'Rejected';
  }
};

export const channelStatusColor = (status: ChannelRequestStatus): string => {
  switch (status) {
    case ChannelRequestStatus.Unconfirmed:
      return 'bg-yellow-100 text-yellow-800';
    case ChannelRequestStatus.Accepted:
      return 'bg-green-100 text-green-800';
    case ChannelRequestStatus.Pending:
      return 'bg-blue-100 text-blue-800';
    case ChannelRequestStatus.Rejected:
      return 'bg-red-100 text-red-800';
  }
};
