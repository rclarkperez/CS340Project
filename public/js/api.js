export async function getVisits() {
  const response = await fetch(`/api/visits`);
  if (!response.ok) {
    const { message } = await response.json();
    alert(message);
    return;
  }

  const data = await response.json();
  return data;
}
