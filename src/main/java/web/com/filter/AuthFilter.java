package web.com.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import web.com.models.Account;

@WebFilter(urlPatterns = { "/admin/*", "/cart/*" })
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        boolean isLoggedIn = (session != null && session.getAttribute("account") != null);

        if (isLoggedIn) {
            String path = req.getRequestURI();

            if (path.startsWith(req.getContextPath() + "/admin")) {
                Account account = (Account) session.getAttribute("account");

                if (account == null || !account.isAdmin()) {
                    resp.sendRedirect(req.getContextPath() + "/home?error=forbidden");
                    return;
                }
            }

            chain.doFilter(request, response);
        } else {

            String target;

            if ("GET".equalsIgnoreCase(req.getMethod())) {
                target = req.getRequestURI();
                String queryString = req.getQueryString();

                if (queryString != null) {
                    target += "?" + queryString;
                }
            } else {
              
                String referer = req.getHeader("Referer");
                target = (referer != null && !referer.isBlank())
                        ? referer
                        : req.getContextPath() + "/home";
            }

            String encodedTarget = java.net.URLEncoder.encode(target, java.nio.charset.StandardCharsets.UTF_8);
            resp.sendRedirect(req.getContextPath() + "/login?redirect=" + encodedTarget);
        }
    }

    @Override
    public void destroy() {
    }
}
