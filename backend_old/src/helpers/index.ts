export function compareArrays(
  oldItems: string[],
  newItems: string[],
): { connect: { id: string }[]; disconnect: { id: string }[] } {
  const connect: { id: string }[] = [];
  const disconnect: { id: string }[] = [];

  const oldSet = new Set(oldItems);
  const newSet = new Set(newItems);

  newSet.forEach((item) => {
    if (!oldSet.has(item)) {
      connect.push({ id: item });
    }
  });

  oldSet.forEach((item) => {
    if (!newSet.has(item)) {
      disconnect.push({ id: item });
    }
  });

  return { connect, disconnect };
}
