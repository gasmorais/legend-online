package mainBar
{
   import chat.view.ChatBugleViewII;
   import chat.view.ChatInputViewII;
   import chat.view.ChatOutputViewII;
   import chat.view.ChatTopBugleView;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ComponentSetting;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   
   public class ChatBar extends Sprite
   {
      
      private static var _instance:ChatBar;
      
      public static var debugSwitch:Boolean = false;
      
      public static var inBattleFlag:Boolean;
      
      public static var isOver:Object;
      
      private var _vBox:VBox;
      
      private var _chatBugleView:ChatBugleViewII;
      
      private var _chatOutputView:ChatOutputViewII;
      
      private var _chatInputView:ChatInputViewII;
      
      private var _upBtn:BaseButton;
      
      private var _downBtn:BaseButton;
      
      public var isMinShow:Boolean = true;
      
      public var isLoaded:Boolean = false;
      
      private var _backList:Vector.<Function> = new Vector.<Function>();
      
      public function ChatBar()
      {
         super();
      }
      
      public static function get instance() : ChatBar
      {
         if(!_instance)
         {
            _instance = new ChatBar();
         }
         return _instance;
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("chatII.VBox");
         _chatBugleView = ComponentFactory.Instance.creatCustomObject("chatII.ChatBugleViewII");
         _chatOutputView = ComponentFactory.Instance.creatCustomObject("chatII.ChatOutputViewII");
         _chatInputView = ComponentFactory.Instance.creatCustomObject("chatII.ChatInputViewII");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputUpBtn");
         _downBtn = ComponentFactory.Instance.creatComponentByStylename("chatII.ChatOutputDownBtn");
         addChild(_vBox);
         addChild(_upBtn);
         addChild(_downBtn);
         _upBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command04");
         _downBtn.tipData = LanguageMgr.GetTranslation("chat.view.ChatView.command05");
      }
      
      private function initEvent() : void
      {
         _upBtn.addEventListener("click",__clickHandler);
         _downBtn.addEventListener("click",__clickHandler);
         MsgMan.addObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      private function updateVbox(param1:String, param2:Object) : void
      {
         if(inBattleFlag || MarryManager.instance.model.lockScreen)
         {
            return;
         }
         refresh();
      }
      
      private function removeEvent() : void
      {
         _upBtn.removeEventListener("click",__clickHandler);
         _downBtn.removeEventListener("click",__clickHandler);
         MsgMan.removeObserver("yishi.datas.consant.BIG_BUGLE_EVENT",this,updateVbox);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         isMinShow = !isMinShow;
         if(param1.currentTarget == _upBtn)
         {
            chatOutPutView.showMaxView();
            __onResize(null);
         }
         else if(param1.currentTarget == _downBtn)
         {
            _loc2_ = chatOutPutView.chatList.height == 234 ? true : false;
            if(!_loc2_)
            {
               chatOutPutView.showBottomView();
            }
            else
            {
               chatOutPutView.showMinView();
            }
            __onResize(null);
         }
      }
      
      private function __completehandler(param1:LoaderInfo, param2:Object) : void
      {
         if(isLoaded)
         {
            return;
         }
         isLoaded = true;
         initView();
         initEvent();
         mouseEnabled = false;
         _vBox.mouseEnabled = false;
         ChatTopBugleView.instance.setup();
         if(_backList.length > 0)
         {
            for each(var _loc3_:Function in _backList)
            {
               if(_loc3_ != null)
               {
                  _loc3_();
               }
            }
            _backList.length = 0;
         }
         else
         {
            show();
         }
      }
      
      public function show(param1:Function = null) : void
      {
         var _loc2_:String = null;
         if(PlayerManager.instance.newbieProcess < 15000)
         {
            return;
         }
         if(!isLoaded)
         {
            if(param1 != null)
            {
               _backList.push(param1);
            }
            _loc2_ = ComponentSetting.getUISourcePath("chat");
            LoaderManagerII.instance.load(_loc2_,3,8,__completehandler);
            return;
         }
         StageReferance.addEventListener("resize",__onResize);
         _chatBugleView.mouseEventObject = null;
         buttonBox.alpha = 1;
         LayerManager.Instance.addToLayer(this,4,false,false,0,2);
         __onResize(null);
      }
      
      public function hide() : void
      {
         if(_chatBugleView)
         {
            _chatBugleView.mouseEventObject = null;
         }
         StageReferance.removeEventListener("resize",__onResize);
         if(_vBox)
         {
            _vBox.beginChanges();
            _vBox.removeAllChild();
            _vBox.commitChanges();
         }
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function showMinView() : void
      {
         isMinShow = !isMinShow;
         chatOutPutView.showMinView();
         __onResize(null);
      }
      
      public function showBottomView() : void
      {
         isMinShow = !isMinShow;
         chatOutPutView.showBottomView();
         __onResize(null);
      }
      
      private function refresh() : void
      {
         if(MarryManager.instance.model.lockScreen)
         {
            hide();
            return;
         }
         _chatBugleView.x = _chatOutputView.x = _chatInputView.x = 0;
         _vBox.beginChanges();
         _vBox.addChild(_chatBugleView);
         _vBox.addChild(_chatOutputView);
         _vBox.addChild(_chatInputView);
         _vBox.commitChanges();
         _vBox.y = -_vBox.height;
      }
      
      private function __onResize(param1:Event = null) : void
      {
         x = 0;
         y = StageReferance.gameStageHeight;
         refresh();
      }
      
      public function get chatInputView() : ChatInputViewII
      {
         return _chatInputView;
      }
      
      public function get chatOutPutView() : ChatOutputViewII
      {
         return _chatOutputView;
      }
      
      public function get chatBugleView() : ChatBugleViewII
      {
         return _chatBugleView;
      }
      
      public function get upBtn() : BaseButton
      {
         return _upBtn;
      }
      
      public function get downBtn() : BaseButton
      {
         return _downBtn;
      }
      
      public function get buttonBox() : HBox
      {
         if(_chatOutputView)
         {
            return _chatOutputView.hBox;
         }
         return null;
      }
   }
}

