package bag360
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.Bag360Manager;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.service.managers.SocketManager;
   
   public class Bag360Frame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleBack:Bitmap;
      
      private var _lineContain:VBox;
      
      private var _level:FilterFrameText;
      
      private var _reward:FilterFrameText;
      
      private var _items:Array;
      
      public function Bag360Frame()
      {
         super();
         initView();
         initEvent();
         getBagState();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function getBagState() : void
      {
         var _loc1_:PackageOut = new PackageOut(8723);
         SocketManager.instance.socket.sendProtobuffer(_loc1_,null);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("bag360.FrameBack");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.bag360.TitleAsset");
         _lineContain = ComponentFactory.Instance.creatComponentByStylename("bag360.Contain");
         _level = ComponentFactory.Instance.creatComponentByStylename("bag360.Level");
         _reward = ComponentFactory.Instance.creatComponentByStylename("bag360.Reward");
         addToContent(_back);
         addToContent(_titleBack);
         addToContent(_lineContain);
         addToContent(_level);
         addToContent(_reward);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.bag360Btn.tipData");
         _level.text = LanguageMgr.GetTranslation("bag360.Bag360Frame.Level");
         _reward.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.rewardText");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         NotificationManager.instance.addEventListener("RECEIVE_BAG_360",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         NotificationManager.instance.removeEventListener("RECEIVE_BAG_360",__updateHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __updateHandler(param1:NotificationEvent) : void
      {
         if(Bag360Manager.instance.allGet)
         {
            dispose();
         }
         else
         {
            refreshView();
         }
      }
      
      private function get hasGetList() : Array
      {
         return Bag360Manager.instance.hasGetList;
      }
      
      private function get levelDic() : Dictionary
      {
         return Bag360Manager.instance.levelDic;
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Bag360Item = null;
         var _loc2_:Bitmap = null;
         _items = [];
         _lineContain.disposeAllChildren();
         _loc3_ = 1;
         while(_loc3_ <= 6)
         {
            _loc1_ = new Bag360Item();
            _loc1_.index = _loc3_;
            if(thane.grades < levelDic[_loc3_])
            {
               _loc1_.state = 2;
            }
            else if(hasGetList.indexOf(_loc3_) >= 0)
            {
               _loc1_.state = 3;
            }
            else
            {
               _loc1_.state = 1;
            }
            _lineContain.addChild(_loc1_);
            if(_loc3_ < 6)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.bag360.LineAsset");
               _lineContain.addChild(_loc2_);
            }
            _items.push(_loc1_);
            _items.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function __response(param1:FrameEvent) : void
      {
         if(param1.responseCode == 1 || param1.responseCode == 0)
         {
            dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_items)
         {
            while(_items.length > 0)
            {
               ObjectUtils.disposeObject(_items.pop());
            }
         }
         _items = null;
         if(_back)
         {
            _back.dispose();
         }
         _back = null;
         if(_titleBack)
         {
            _titleBack.bitmapData.dispose();
         }
         _titleBack = null;
         if(_lineContain)
         {
            _lineContain.dispose();
         }
         _lineContain = null;
         if(_level)
         {
            _level.dispose();
         }
         _level = null;
         if(_reward)
         {
            _reward.dispose();
         }
         _reward = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

