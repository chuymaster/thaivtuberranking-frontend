export const ITEMS_PER_PAGE = 50;

export function paginateItems<T>(items: T[], page: number): T[] {
  const startIndex = (page - 1) * ITEMS_PER_PAGE;
  const endIndex = startIndex + ITEMS_PER_PAGE;
  return items.slice(startIndex, endIndex);
}

export function getTotalPages(totalItems: number): number {
  return Math.ceil(totalItems / ITEMS_PER_PAGE);
}

export function getPageNumbers(currentPage: number, totalPages: number): number[] {
  const pageNumbers: number[] = [];
  const maxVisiblePages = 7;

  if (totalPages <= maxVisiblePages) {
    for (let i = 1; i <= totalPages; i++) {
      pageNumbers.push(i);
    }
  } else {
    if (currentPage <= 4) {
      for (let i = 1; i <= 5; i++) {
        pageNumbers.push(i);
      }
      pageNumbers.push(-1); // Ellipsis
      pageNumbers.push(totalPages);
    } else if (currentPage >= totalPages - 3) {
      pageNumbers.push(1);
      pageNumbers.push(-1);
      for (let i = totalPages - 4; i <= totalPages; i++) {
        pageNumbers.push(i);
      }
    } else {
      pageNumbers.push(1);
      pageNumbers.push(-1);
      for (let i = currentPage - 1; i <= currentPage + 1; i++) {
        pageNumbers.push(i);
      }
      pageNumbers.push(-1);
      pageNumbers.push(totalPages);
    }
  }

  return pageNumbers;
}
