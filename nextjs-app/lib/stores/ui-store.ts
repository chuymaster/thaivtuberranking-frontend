'use client';

import { create } from 'zustand';

interface UIState {
  isDrawerOpen: boolean;
  searchQuery: string;
  setDrawerOpen: (open: boolean) => void;
  setSearchQuery: (query: string) => void;
}

export const useUIStore = create<UIState>((set) => ({
  isDrawerOpen: false,
  searchQuery: '',
  setDrawerOpen: (open) => set({ isDrawerOpen: open }),
  setSearchQuery: (query) => set({ searchQuery: query }),
}));
