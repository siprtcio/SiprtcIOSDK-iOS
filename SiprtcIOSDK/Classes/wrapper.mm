
#import "wrapper.h"
#import "CustomPJSUA2.hpp"

/**
 Create a object from .hpp class & wrapper to be able to use it via Swift
 */
@implementation CPPWrapper
PJSua2 pjsua2;

//Lib
/**
 Create Lib with EpConfig
 */
-(void) createLibWrapper
{
    return pjsua2.createLib();
};

/**
 Delete lib
 */
-(void) deleteLibWrapper {
    pjsua2.deleteLib();
}

//Account
/**
 Create Account via following config(string username, string password, string ip, string port)
 */
-(void) createAccountWrapper :(NSString*) usernameNS :(NSString*) passwordNS
                             :(NSString*) registrarNS :(NSString*) portNS
{
    std::string username = std::string([[usernameNS componentsSeparatedByString:@"*"][0] UTF8String]);
    std::string password = std::string([[passwordNS componentsSeparatedByString:@"*"][0] UTF8String]);
    std::string registrar = std::string([[registrarNS componentsSeparatedByString:@"*"][0] UTF8String]);
    std::string port = std::string([[portNS componentsSeparatedByString:@"*"][0] UTF8String]);
    
    pjsua2.createAccount(username, password, registrar, port);
}

/**
 Unregister account
 */
-(void) unregisterAccountWrapper {
    return pjsua2.unregisterAccount();
}

/**
 Answer incoming call
 */
- (void) answerCallWrapper {
    pjsua2.answerCall();
}

/**
 Hangup active call (Incoming/Outgoing/Active)
 */
- (void) hangupCallWrapper {
    pjsua2.hangupCall();
}

/**
 Hold the call
 */
- (void) holdCallWrapper{
    pjsua2.holdCall();
}

/**
 unhold the call
 */
- (void) unholdCallWrapper{
    pjsua2.unholdCall();
}

/**
 Make outgoing call (string dest_uri) -> e.g. makeCall(sip:<SIP_USERNAME@SIP_URI:SIP_PORT>)
 */
-(void) outgoingCallWrapper :(NSString*) dest_uriNS
{
    std::string dest_uri = std::string([[dest_uriNS componentsSeparatedByString:@"*"][0] UTF8String]);
    pjsua2.outgoingCall(dest_uri);
}

// Factory method to create NSString from C++ string
/**
 Get caller id for incoming call, checks account currently registered (ai.regIsActive)
 */
- (NSString*) incomingCallInfoWrapper {
    NSString* result = [NSString stringWithUTF8String:pjsua2.incomingCallInfo().c_str()];
    return result;
}

/**
 Listener (When we have incoming call, this function pointer will notify swift.)
 */
- (void)incoming_call_wrapper: (void(*)())function {
    pjsua2.incoming_call(function);
}

/**
 Listener (When we have changes on the call state, this function pointer will notify swift.)
 */
- (void)call_listener_wrapper: (void(*)(int))function {
    pjsua2.call_listener(function);
}

/**
 Listener (When we have changes on the acc reg state, this function pointer will notify swift.)
 (Runs swift code from C++)
 */
-(void) acc_listener_wrapper: (void(*)(bool))function {
    pjsua2.acc_listener(function);
}

/**
 Listener (When we have video, this function pointer will notify swift.)
 (Runs swift code from C++)
 */
-(void) update_video_wrapper: (void(*)(void *))function {
    pjsua2.update_video(function);
}

@end

