package co.yiiu.pybbs.vote.controller;

import co.yiiu.pybbs.controller.front.BaseController;
import co.yiiu.pybbs.vote.tool.GetDate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController extends BaseController {
    @RequestMapping("/public/cn")
    public String pubCn(Model model) {
        model.addAttribute("YEAR", GetDate.year());
        return render("vote/public/public_cn");
    }
}
