<template>
  <div>
    <div v-for="job in jobs">
        <p> {{job.title}} </p>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return this.$root.$data.state; // Make data more easily accessible
  }
};
</script>