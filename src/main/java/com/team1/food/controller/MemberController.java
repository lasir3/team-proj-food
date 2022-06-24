package com.team1.food.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.team1.food.domain.MemberDto;
import com.team1.food.service.MailSendService;
import com.team1.food.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@Autowired
	private MailSendService mailService;

	@GetMapping("signup")
	public void signupForm() {
		
	}

    
    @GetMapping(path="check", params="id")
    @ResponseBody
    public String idcheck(String id) {        
        boolean exist = service.hasMemberId(id);   
        
        if (exist) {            
        	return "notOk";
        } else {           
        	return "ok";
        }

    }
    
	/*
	 * @GetMapping(path = "check", params = "email")
	 * 
	 * @ResponseBody public String emailCheck(String email) { boolean exist =
	 * service.hasMemberEmail(email);
	 * 
	 * if (exist) { return "notOk"; } else { return "ok"; }
	 * 
	 * }
	 */
    
	//회원가입 페이지 이동
	@GetMapping("/userJoin")
	public void userJoin() {}
	
	//이메일 인증
	@GetMapping("/confirmemail")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("이메일 인증 요청이 들어옴!");
		System.out.println("이메일 인증 이메일 : " + email);
		return mailService.joinEmail(email);
		
			
	}
    
	@GetMapping(path = "check", params = "nickName")
	@ResponseBody
	public String nickNameCheck(String nickName) {
		
		boolean exist = service.hasMemberNickName(nickName);
		
		if (exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
    @PostMapping("signup")
    public String signupProcess(MemberDto member, RedirectAttributes rttr) {
        boolean success = service.addMember(member);
        
        if (success) {
            rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
            return "redirect:/member/signup";

        } else {
            rttr.addFlashAttribute("message", "회원가입이 실패하였습니다.");
            rttr.addFlashAttribute("member", member);           
            return "redirect:/member/signup";
        }
    }
    
    @GetMapping("memberlist")
    public void list(Model model) {
        List<MemberDto> list = service.listMember();
        model.addAttribute("memberList", list);

    }
    
    @GetMapping("memberget")
    public void getMember(String id, Model model) {
        MemberDto member = service.getMemberById(id);
        model.addAttribute("member", member);       
    }
    

    @PostMapping("remove")
    public String removeMember(MemberDto dto, RedirectAttributes rttr) {
        boolean success = service.removeMember(dto);
        
        if (success) {
            rttr.addFlashAttribute("message", "회원 탈퇴 되었습니다.");
            return "redirect:/member/memberlist";
        } else {
            rttr.addAttribute("id", dto.getId());
            return "redirect:/member/memberget";
        }      
    }
    
    @PostMapping("modify")
    public String modifyMember(MemberDto dto, String oldPassword, RedirectAttributes rttr) {       

        boolean success = service.modifyMember(dto, oldPassword);
        
        if (success) {
            rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
        } else {
            rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
        }
       
        rttr.addFlashAttribute("member", dto); // model object
        rttr.addAttribute("id", dto.getId()); // query string
        
        return "redirect:/member/memberget";

    }
    
	@GetMapping("login")
	public void loginPage() {
		
	}


}
