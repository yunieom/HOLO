const { Router } = require('express');
const router = Router();
const userService = require('../services/userService');

// 회원가입 라우터
router.post('/register', async (req, res) => {
    // 유저 정보 가져옴
    const userInfo = req.body;

    // 정상 처리될 시 가입 응답 전송
    try {
        const newUser = await userService.register(userInfo);
        res.status(201).json({
            message: '회원가입이 완료되었습니다.', user: newUser
        });
        // 문제 발생시 오류 전송
    } catch (err) {
        console.log(err);
        res.status(400).send(`${err}`);
    }
});

module.exports = router;