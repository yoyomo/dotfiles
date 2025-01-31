// Paste this code in Soundiiz's Syncs page (https://soundiiz.com/webapp/scheduleds)

const NUMBER_OF_PLAYLISTS = 32

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

const individualSync = async (playlist) => {
    playlist.click() // open playlist
    // wait til it loads
    while (!document.querySelector(".main-line").innerText.includes("Synchronization details")) {
        await new Promise(r => setTimeout(r, 300));
    }
    document.querySelector(".schedule-starter").click() // click run now
    // wait till sync is done
    while (!document.querySelector('span[title="Running"]')) {
        await new Promise(r => setTimeout(r, 300));
    }
    while (document.querySelector('span[title="Running"]')) {
        await new Promise(r => setTimeout(r, 1000));
    }

    document.querySelector('button[title="Back"]').click() // close playlist
    // wait till it closes
    while (!document.querySelector(".main-line").innerText.includes("My synchronizations")) {
        await new Promise(r => setTimeout(r, 300));
    }
}

const syncPlaylist = async () => {
    // Get first sync with " | " in the title
    // Note: the first sync goes to the bottom of the filter once it ran
    playlist = Array.from(document.querySelectorAll(".list-row")).find(row => row.innerText.includes(" | "))
    playlistTitle = playlist.querySelector(".item-title").innerText
    console.log(`Syncing ${playlistTitle}`)

    await individualSync(playlist)

    console.log(`Sync done ${playlistTitle}`)
}

const main = async () => {
    prepareSync()
    for (let i = 0; i < NUMBER_OF_PLAYLISTS; i++) {
        await syncPlaylist()
    }
}
