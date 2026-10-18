package chat.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   
   public class InputChannelList extends Sprite implements Disposeable
   {
      
      private var _bg:DisplayObject;
      
      private var _list:MovieClip;
      
      private var _channel:int = 1;
      
      private var _btnDic:Dictionary;
      
      public function InputChannelList()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         for each(var _loc1_:TextButton in _btnDic)
         {
            _loc1_.addEventListener("click",__channelBtnClick);
         }
         NotificationManager.instance.addEventListener("OUTYARD_CHANNEL_CHANGE",__outyardChannelHandler);
         __outyardChannelHandler(null);
      }
      
      private function __channelBtnClick(param1:MouseEvent) : void
      {
         for(var _loc2_:String in _btnDic)
         {
            if(_btnDic[_loc2_] == param1.currentTarget)
            {
               _channel = int(_loc2_);
               break;
            }
         }
         NotificationManager.instance.sendNotification("INPUT_CHANNEL_CHANGE",_channel);
         dispose();
      }
      
      private function initView() : void
      {
         _btnDic = new Dictionary();
         _bg = ComponentFactory.Instance.creat("core.commonTipBg");
         _bg.width = 91;
         _bg.height = 107;
         addChild(_bg);
         _btnDic[1] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelBugleSelectBtn");
         (_btnDic[1] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.BugleBtnText");
         _btnDic[10] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelWorldSelectBtn");
         (_btnDic[10] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.WorldBtnText");
         _btnDic[109] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelOutyardSelectBtn");
         (_btnDic[109] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.OutyardBtnText");
         _btnDic[6] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelTeamSelectBtn");
         (_btnDic[6] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.TeamBtnText");
         _btnDic[5] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelConsortiaSelectBtn");
         (_btnDic[5] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.ConsortiaBtnText");
         _btnDic[8] = ComponentFactory.Instance.creatComponentByStylename("chatII.PanelCurrentSelectBtn");
         (_btnDic[8] as TextButton).text = LanguageMgr.GetTranslation("chatII.view.InputChannelList.CurrentBtnText");
      }
      
      private function __outyardChannelHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:TextButton in _btnDic)
         {
            if(_loc2_.parent)
            {
               _loc2_.parent.removeChild(_loc2_);
            }
         }
         if(!FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            addChild(_btnDic[1]);
            addChild(_btnDic[10]);
            addChild(_btnDic[6]);
            addChild(_btnDic[5]);
            addChild(_btnDic[8]);
         }
         else
         {
            addChild(_btnDic[1]);
            addChild(_btnDic[109]);
            addChild(_btnDic[6]);
            addChild(_btnDic[5]);
            addChild(_btnDic[8]);
         }
      }
      
      public function get channel() : int
      {
         return _channel;
      }
      
      public function dispose() : void
      {
         NotificationManager.instance.removeEventListener("OUTYARD_CHANNEL_CHANGE",__outyardChannelHandler);
         for each(var _loc1_:TextButton in _btnDic)
         {
            _loc1_.removeEventListener("click",__channelBtnClick);
         }
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         dispatchEvent(new Event("dispose"));
      }
   }
}

