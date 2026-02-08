'use client';

import Image, { ImageProps } from 'next/image';
import { useState } from 'react';

interface SafeImageProps extends Omit<ImageProps, 'onError'> {
  fallbackClassName?: string;
}

export function SafeImage({ fallbackClassName, className, ...props }: SafeImageProps) {
  const [hasError, setHasError] = useState(false);

  if (hasError) {
    return (
      <div 
        className={fallbackClassName || className || ''} 
        style={{ backgroundColor: '#e5e7eb' }}
      />
    );
  }

  return (
    <Image
      {...props}
      className={className}
      onError={() => setHasError(true)}
    />
  );
}
