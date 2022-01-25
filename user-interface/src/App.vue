<template>
  <div id="app">
    <h1><span class="amp">Amp</span><span class="video">Video</span></h1>
    <input
      ref="searchbar"
      v-model="searchTerm"
      class="searchbar"
      placeholder="Search..."
      @input="getMatchingVideos"
    />

    <section class="video-options">
      <div
        v-for="(video, i) in matchingVideos"
        :key="i"
        class="dropdown"
        @click="() => selectVideo(i)"
      >
        {{ video.title }}
      </div>
    </section>
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
    }
  },
  mounted() {
    this.$refs.searchbar.focus()
  },
  methods: {
    async getMatchingVideos() {
      await axios
        .get(`http://localhost:3000/videos?search_term=${this.searchTerm}`)
        .then((resp) => (this.matchingVideos = resp.data))
    },
    selectVideo(index) {
      this.selectedVideo = this.matchingVideos[index]
      this.$refs.searchbar.focus()
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
  cursor: pointer;

  &:hover {
    background-color: #eee;
  }
}

section div:last-of-type {
  border-bottom: 1px solid black;
}
</style>
