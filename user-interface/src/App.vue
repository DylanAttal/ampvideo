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
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      searchTerm: '',
    }
  },
  mounted() {
    this.$refs.searchbar.focus()
  },
  methods: {
    async getMatchingVideos() {
      await axios.get(
        `http://localhost:3000/videos?search_term=${this.searchTerm}`
      )
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
</style>
