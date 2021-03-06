<template>
  <div id="app">
    <h1><span class="amp">Amp</span><span class="video">Video</span></h1>
    <input
      ref="searchbar"
      v-model="searchInput"
      class="searchbar"
      placeholder="Search..."
      @keypress.enter="selectVideoWithEnter"
    />

    <section class="video-options" v-show="showVideoOptions">
      <div
        v-for="(video, i) in matchingVideos"
        :key="i"
        class="dropdown"
        :style="{
          cursor: video.title === 'No suggestions' ? 'not-allowed' : 'pointer',
        }"
        @click="() => selectVideo(i)"
      >
        {{ video.title }}
      </div>
    </section>

    <div class="selected-video" v-show="selectedVideo.title">
      <img :src="selectedVideo.thumbnail" alt="Selected video thumbnail." />
      <div class="selected-video-text">
        <p class="video-title">{{ selectedVideo.title }}</p>
        <p>{{ selectedVideo.views }} views - {{ selectedVideo.owner }}</p>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      searchTerm: '',
      matchingVideos: [],
      selectedVideo: {
        title: '',
        thumbnail: '',
        owner: '',
        views: '',
        rank: '',
      },
      showVideoOptions: false,
      timeout: null,
    }
  },
  mounted() {
    this.$refs.searchbar.focus()
  },
  computed: {
    searchInput: {
      get() {
        return this.searchTerm
      },
      set(val) {
        this.showVideoOptions = true

        if (this.timeout) {
          clearTimeout(this.timeout)
        }

        this.timeout = setTimeout(() => {
          this.searchTerm = val
          this.getMatchingVideos()
        }, 300)
      },
    },
  },
  methods: {
    async getMatchingVideos() {
      if (this.searchTerm === '') {
        this.matchingVideos = []
        return
      }

      await axios
        .get(`http://localhost:3000/videos?search_term=${this.searchTerm}`)
        .then((resp) => (this.matchingVideos = resp.data))
    },
    selectVideo(index) {
      if (
        this.matchingVideos.length === 1 &&
        this.matchingVideos[0].title === 'No suggestions'
      ) {
        return
      }

      this.selectedVideo = this.matchingVideos[index]
      this.showVideoOptions = false
      this.$refs.searchbar.focus()
    },
    selectVideoWithEnter() {
      for (let i = 0; i < this.matchingVideos.length; i++) {
        if (this.searchInput === this.matchingVideos[i].title) {
          this.selectedVideo = this.matchingVideos[i]
          this.showVideoOptions = false
          this.$refs.searchbar.focus()
        }
      }
    },
  },
}
</script>

<style lang="scss">
body {
  margin: 0;
}

#app {
  font-family: Helvetica, sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  height: 100vh;
  width: 100vw;
}

h1 {
  font-weight: 100;
  font-size: 3rem;
}

.amp {
  color: #cc3333;
}

.video {
  color: #333;
}

.searchbar {
  width: 50%;
  font-size: 1rem;
  padding: 0.5rem;
}

.video-options {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.dropdown {
  width: 50%;
  padding: 0.5rem;
  border-right: 1px solid black;
  border-left: 1px solid black;

  &:hover {
    background-color: #eee;
  }
}

section div:last-of-type {
  border-bottom: 1px solid black;
}

.selected-video {
  margin: 3rem;
  display: flex;
  justify-content: space-around;
}

.selected-video-text {
  display: flex;
  flex-direction: column;
  justify-content: space-around;
  align-items: flex-start;
  padding-left: 1rem;
  padding-right: 1rem;
}

.video-title {
  color: #333;
  font-weight: 600;
  font-size: 1.2rem;
}
</style>
