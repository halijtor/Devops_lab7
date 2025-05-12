import axios from "../customAxiosConfig/CustomAxiosConfig";

const SignUpAppClientService = (user) => {
  try {
    return axios.post(`/auth/signup`, user);
  } catch (err) {
    let error = "";
    if (err.response) {
      error += err.response;
    }
    return error;
  }
};

export default SignUpAppClientService;
