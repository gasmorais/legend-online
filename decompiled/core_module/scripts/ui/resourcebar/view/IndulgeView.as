package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.player.PlayerAASRefreshMsg;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Timer;
   import mainBar.view.IndulgeInfoFrame;
   import manager.LanguageMgr;
   import ui.resourcebar.ResourcesBar;
   import yishi.comm.PackageOut;
   import yishi.datas.UserInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.ConfigManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.DateFormatter;
   
   public class IndulgeView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _icons:ScaleFrameImage;
      
      private var _describe:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _time:Timer;
      
      private var _timeStr:String;
      
      private var _tipStr:String = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip");
      
      private var _frame:IndulgeInfoFrame;
      
      public function IndulgeView()
      {
         super();
         initView();
         initEvent();
         this.buttonMode = true;
         onIndygleTime();
      }
      
      private function firstLoadTime() : void
      {
         var _loc1_:UserInfo = null;
         var _loc3_:URLLoader = null;
         var _loc2_:String = null;
         if(PlayerManager.instance.currentPlayerModel.indulgeTime > 0)
         {
            _time.start();
            showTipData();
            showFrameContent();
            showFrame();
         }
         else
         {
            _loc1_ = PlayerManager.instance.currentPlayerModel.userInfo;
            _loc3_ = new URLLoader();
            _loc3_.addEventListener("complete",__aasTimeloadComplete);
            _loc2_ = "http://fcm.ddshenqu.cn/aasservlet?op=2&UserName=" + _loc1_.user + "&Site=" + _loc1_.site;
            _loc3_.load(new URLRequest(_loc2_ + "&rnd=" + Math.random().toString()));
         }
      }
      
      private function __aasTimeloadComplete(param1:Event) : void
      {
         var _loc4_:PackageOut = null;
         var _loc2_:PlayerAASRefreshMsg = null;
         var _loc3_:Number = Number(param1.target.data);
         if(_loc3_ == -100)
         {
            ResourcesBar.instance.closeIndulgeView();
            return;
         }
         PlayerManager.instance.currentPlayerModel.indulgeTime = _loc3_;
         _loc4_ = new PackageOut(8261);
         _loc2_ = new PlayerAASRefreshMsg();
         _loc2_.aasOnlineTime = Number(param1.target.data);
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc2_);
         _time.start();
         showTipData();
         showFrameContent();
         showFrame();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeView.Back");
         _icons = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeView.Icons");
         _describe = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeView.Describe");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeView.TimeTxt");
         addChild(_back);
         addChild(_icons);
         addChild(_describe);
         addChild(_timeTxt);
         mouseChildren = false;
         _icons.setFrame(1);
         _describe.text = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.describe");
         _time = new Timer(1000);
      }
      
      private function onIndygleTime(param1:Event = null) : void
      {
         var _loc3_:PackageOut = null;
         var _loc2_:PlayerAASRefreshMsg = null;
         if(!PlayerManager.instance.currentPlayerModel.isInAAS)
         {
            ResourcesBar.instance.closeIndulgeView();
            return;
         }
         _loc3_ = new PackageOut(8261);
         _loc2_ = new PlayerAASRefreshMsg();
         _loc2_.aasOnlineTime = PlayerManager.instance.currentPlayerModel.indulgeTime;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
         _time.start();
         showTipData();
         showFrameContent();
         showFrame();
      }
      
      private function initEvent() : void
      {
         addEventListener("click",__clickHandler);
         _time.addEventListener("timer",__timerHandler);
         NotificationManager.instance.addEventListener("UPDATE_INDYGLE_TIME",onIndygleTime);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__clickHandler);
         _time.removeEventListener("timer",__timerHandler);
         NotificationManager.instance.removeEventListener("UPDATE_INDYGLE_TIME",onIndygleTime);
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         var _loc6_:PackageOut = null;
         var _loc2_:PlayerAASRefreshMsg = null;
         var _loc5_:Boolean = ConfigManager.info.AAS;
         if(!_loc5_)
         {
            ResourcesBar.instance.closeIndulgeView();
            return;
         }
         var _loc4_:Number = model.indulgeTime + _time.currentCount;
         var _loc3_:int = _loc4_ / 3600;
         var _loc7_:int = _loc4_ % 3600 / 60;
         if(_loc7_ % 15 == 0 && _loc4_ % 3600 % 60 == 0)
         {
            if(_frame)
            {
               if(!_frame.isDie)
               {
                  _frame.dispose();
               }
               _frame = null;
            }
            if(_loc3_ >= 5)
            {
               showTipData();
               showFrameContent();
               showFrame();
            }
            else if(_loc3_ == 3 && _loc7_ % 60 == 0)
            {
               showTipData();
               showFrameContent();
               showFrame();
            }
            else if(_loc3_ >= 3 && _loc7_ % 30 == 0)
            {
               showTipData();
               showFrameContent();
               showFrame();
            }
            else if(_loc3_ != 0 && _loc7_ % 60 == 0)
            {
               showTipData();
               showFrameContent();
               showFrame();
            }
         }
         _timeTxt.text = DateFormatter.getCountDate(model.indulgeTime + _time.currentCount);
         if(_loc7_ % 5 == 0 && _loc4_ % 3600 % 60 == 0)
         {
            _loc6_ = new PackageOut(8261);
            _loc2_ = new PlayerAASRefreshMsg();
            _loc2_.aasOnlineTime = model.indulgeTime + _time.currentCount;
            SocketSendManager.instance.sendProtoBuffer(_loc6_,_loc2_);
         }
      }
      
      private function showFrame() : void
      {
         _frame = ComponentFactory.Instance.creatComponentByStylename("resoueceBar.IndulgeInfoFrame");
         _frame.timeTxt = _timeStr;
         _frame.show();
      }
      
      private function showFrameContent() : void
      {
         var _loc2_:Number = model.indulgeTime + _time.currentCount;
         var _loc1_:int = _loc2_ / 3600;
         var _loc3_:int = _loc2_ % 3600 / 60;
         if(_loc1_ >= 5)
         {
            _icons.setFrame(3);
            _timeStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.time01");
         }
         else if(_loc1_ == 3 && _loc3_ % 60 == 0)
         {
            _icons.setFrame(2);
            _timeStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.time02");
         }
         else if(_loc1_ >= 3)
         {
            _icons.setFrame(2);
            _timeStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.time03");
         }
         else
         {
            _icons.setFrame(1);
            _timeStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.time04",_loc1_);
         }
      }
      
      public function showTipData() : void
      {
         var _loc2_:Number = model.indulgeTime + _time.currentCount;
         var _loc1_:int = _loc2_ / 3600;
         var _loc3_:int = _loc2_ % 3600 / 60;
         if(_loc1_ >= 5)
         {
            _tipStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip01",_loc1_);
         }
         else if(_loc1_ >= 3)
         {
            _tipStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip02",_loc1_);
         }
         else if(_loc1_ != 0)
         {
            _tipStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip03",_loc1_);
         }
         else
         {
            _tipStr = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip04");
         }
         tipData = LanguageMgr.GetTranslation("mainBar.view.IndulgeView.tip05",_tipStr);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         showFrame();
      }
      
      private function get model() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         _time.stop();
         removeEvent();
         _time = null;
         if(_frame)
         {
            if(!_frame.isDie)
            {
               _frame.dispose();
            }
            _frame = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

