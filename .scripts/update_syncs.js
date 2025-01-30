// Paste this code in Soundiiz's Syncs page (https://soundiiz.com/webapp/scheduleds)

// const listSync = async (playlist) => {

//     // open toolbar
//     playlist.querySelector(".column-toolbar button").click()
//     // click run now
//     document.querySelector(".schedule-starter").click()
//     // wait till sync is done
//     while(document.querySelector('span[title="Running"]')){
//         await new Promise(r => setTimeout(r, 1000));
//     }

//     list = document.querySelector(".ReactVirtualized__List")

//     // scroll to the bottom and keep checking
//     list.scrollTo(0, list.scrollHeight)
//     while(document.querySelector('span[title="Running"]')){
//         await new Promise(r => setTimeout(r, 1000));
//     }

//     list.scrollTo(0, 0)
// }

const individualSync = async (playlist) => {
    playlist.click() // open playlist
    // wait til it loads
    document.querySelector(".schedule-starter").click() // click run now
    // wait till sync is done
    while (document.querySelector('span[title="Running"]')) {
        await new Promise(r => setTimeout(r, 1000));
    }

    document.querySelector('button[title="Back"]').click() // close playlist
}

const prepareSync = () => {
    // Filter by last exec
    headers = Array.from(document.querySelectorAll(".filter-order-by-list-header"))
    lastExecFilter = headers.find(header => header.innerText === "Last exec")
    lastExecFilter.click()

    // TODO: Filter in search bar by " | "
    // searchInput = document.querySelector(".search-input")
    // searchInput.value = " | "
    // events not triggered
}

const syncPlaylist = async () => {
    // Get first sync with " | " in the title
    // Note: the first sync goes to the bottom once it ran
    playlist = Array.from(document.querySelectorAll(".list-row")).find(row => row.innerText.includes(" | "))
    playlistTitle = playlist.querySelector(".item-title").innerText
    console.log(`Syncing ${playlistTitle}`)

    // await listSync(playlist)
    await individualSync(playlist)

    console.log(`Sync done ${playlistTitle}`)
}

prepareSync()
// TODO: while there are playlists to sync
for (let i = 0; i < 32; i++) {
    await syncPlaylist()
}