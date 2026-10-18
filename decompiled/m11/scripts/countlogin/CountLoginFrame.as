package countlogin
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import countlogin.view.CountLoginItem;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   
   public class CountLoginFrame extends Frame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleBack:Bitmap;
      
      private var _lineContain:VBox;
      
      private var _loginDate:FilterFrameText;
      
      private var _reward:FilterFrameText;
      
      private var _items:Array;
      
      public function CountLoginFrame()
      {
         super();
         _items = [];
         initView();
         initEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("countlogin.FrameBack");
         _titleBack = ComponentFactory.Instance.creatBitmap("asset.countlogin.TitleAsset");
         _lineContain = ComponentFactory.Instance.creatComponentByStylename("countlogin.Contain");
         _loginDate = ComponentFactory.Instance.creatComponentByStylename("countlogin.LoginDate");
         _reward = ComponentFactory.Instance.creatComponentByStylename("countlogin.Reward");
         addToContent(_back);
         addToContent(_titleBack);
         addToContent(_lineContain);
         addToContent(_loginDate);
         addToContent(_reward);
         titleText = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.titleText");
         _loginDate.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.loginDateText");
         _reward.text = LanguageMgr.GetTranslation("countlogin.CountLoginFrame.rewardText");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__response);
         playerInfo.addEventListener("RELOGINPROCESS_UPDATE",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__response);
         playerInfo.removeEventListener("RELOGINPROCESS_UPDATE",__updateHandler);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __updateHandler(param1:PlayerEvent) : void
      {
         if(!playerInfo.exitUnReceivedLogin())
         {
            dispose();
         }
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CountLoginItem = null;
         var _loc2_:Bitmap = null;
         _loc3_ = 1;
         while(_loc3_ <= 7)
         {
            _loc1_ = new CountLoginItem();
            _loc1_.index = _loc3_;
            _loc2_ = ComponentFactory.Instance.creatBitmap("asset.countlogin.LineAsset");
            _lineContain.addChild(_loc1_);
            if(_loc3_ < 7)
            {
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
            _lineContain.disposeAllChildren();
            _lineContain.dispose();
         }
         _lineContain = null;
         if(_loginDate)
         {
            _loginDate.dispose();
         }
         _loginDate = null;
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

