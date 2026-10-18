package specialfunny
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import funny.datas.FunnyBagData;
   import funny.datas.FunnyData;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.ModuleFrameInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class TimingRewardFrame extends Frame
   {
      
      private var _back1:ScaleBitmapImage;
      
      private var _back2:ScaleBitmapImage;
      
      private var _back3:Scale9CornerImage;
      
      private var _desTxt:GradientText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _getBtn:IconButton;
      
      private var _hBox1:HBox;
      
      private var _hBox2:HBox;
      
      public function TimingRewardFrame()
      {
         super();
         FunnyManager.instance.sendGetBag(1);
         FunnyManager.instance.selectedId = bagData.activeId;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.timingBtn.tipData");
         _back1 = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.back1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.back2");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.back3");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.desTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.timeText");
         _getBtn = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.getBtn");
         _hBox1 = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.hBox1");
         _hBox2 = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.hBox2");
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_back3);
         addToContent(_getBtn);
         addToContent(_desTxt);
         addToContent(_timeTxt);
         addToContent(_hBox1);
         addToContent(_hBox2);
         setView();
         _desTxt.text = LanguageMgr.GetTranslation("onlinereward.TimingRewardFrame.desTxt");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.addEventListener("click",__getHandler);
         }
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_getBtn)
         {
            _getBtn.removeEventListener("click",__getHandler);
         }
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__updateHandler);
      }
      
      private function __getHandler(param1:MouseEvent) : void
      {
         if(_getBtn)
         {
            _getBtn.enable = false;
         }
         if(bagData == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate"));
            dispose();
            return;
         }
         if(bagData.status == 1)
         {
            FunnyManager.instance.sendGetBag(2,bagData.activeId,bagData.id);
         }
         else
         {
            dispose();
         }
      }
      
      private function __updateHandler(param1:FunnyEvent) : void
      {
         if(bagData == null)
         {
            dispose();
            return;
         }
         setView();
      }
      
      private function setView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc1_:FilterFrameText = null;
         _hBox1.disposeAllChildren();
         _hBox2.disposeAllChildren();
         _loc3_ = 0;
         while(_loc3_ < bagData.rewardList.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("onlinereward.BaseItemView");
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = bagData.rewardList[_loc3_].temId;
            _loc4_.count = bagData.rewardList[_loc3_].count;
            _loc2_.data = _loc4_;
            _hBox1.addChild(_loc2_);
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("TimingRewardFrame.txt");
            _loc1_.text = _loc4_.templateInfo.TemplateName;
            _loc1_.setFrame(_loc4_.templateInfo.Profile);
            _hBox2.addChild(_loc1_);
            _loc3_++;
         }
         _hBox1.refreshChildPos();
         _hBox2.refreshChildPos();
         _back3.width = _hBox1.width + 12;
         if(_back3.width < 286)
         {
            _back3.width = 286;
            _hBox1.x = _back3.x + (310 - _hBox1.width) / 2;
         }
         else
         {
            _hBox1.x = 23;
         }
         _hBox2.x = _hBox1.x - 10;
         _back2.width = _back3.width + 16;
         _back1.width = _back2.width + 6;
         width = _back1.width + 23;
         if(bagData.status == 1)
         {
            _getBtn.iconStyle = "asset.onlinereward.getReward2";
            _desTxt.visible = false;
            _timeTxt.visible = false;
         }
         else
         {
            _getBtn.iconStyle = "asset.onlinereward.later";
            _desTxt.visible = true;
            _timeTxt.visible = true;
            _timeTxt.text = FunnyManager.instance.model.timingStr;
         }
         _getBtn.enable = true;
         _getBtn.x = _back3.x + _back3.width / 2 - _getBtn.width / 2;
         _desTxt.x = _back3.x + _back3.width / 2 - _desTxt.width / 2;
         _timeTxt.x = _desTxt.x + 69;
      }
      
      override public function set width(param1:Number) : void
      {
         if(_back1)
         {
            super.width = _back1.width + 23;
         }
         else
         {
            super.width = param1;
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get funnyData() : FunnyData
      {
         return FunnyManager.instance.model.findDataByType(50);
      }
      
      private function get bagData() : FunnyBagData
      {
         return FunnyManager.instance.model.timingBagData;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,331,290);
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back1);
         _back1 = null;
         ObjectUtils.disposeObject(_back2);
         _back2 = null;
         ObjectUtils.disposeObject(_back3);
         _back3 = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_getBtn);
         _getBtn = null;
         ObjectUtils.disposeObject(_hBox1);
         _hBox1 = null;
         ObjectUtils.disposeObject(_hBox2);
         _hBox2 = null;
         super.dispose();
      }
   }
}

