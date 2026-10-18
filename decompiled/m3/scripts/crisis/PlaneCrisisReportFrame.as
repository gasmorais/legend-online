package crisis
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import crisis.ui.PlaneCrisisRewardTipView;
   import crisis.ui.item.PlaneCrisisReportPItem;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisGameOverPlayInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class PlaneCrisisReportFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _rewardBox:HBox;
      
      private var _playerBox:VBox;
      
      private var _linkTxt:TextButton;
      
      private var _contentTitleTxt:FilterFrameText;
      
      private var _leftActionNumData:BitmapData;
      
      private var _leftSp:Sprite;
      
      private var _tipView:PlaneCrisisRewardTipView;
      
      private var _desTxt:FilterFrameText;
      
      public function PlaneCrisisReportFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.reportBack");
         _rewardBox = ComponentFactory.Instance.creatCustomObject("planecrisis.gameOverRewardBox");
         _playerBox = ComponentFactory.Instance.creatCustomObject("planecrisis.gameOverPlayerBox");
         _contentTitleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.report.contentTitleTxt");
         _linkTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.report.linkBtn");
         _leftActionNumData = ComponentFactory.Instance.creatBitmap("asset.planecrisis.numData").bitmapData;
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planeCrisis.reportDesTxt");
         _leftSp = new Sprite();
         addToContent(_bg);
         addToContent(_rewardBox);
         addToContent(_playerBox);
         addToContent(_contentTitleTxt);
         addToContent(_linkTxt);
         addToContent(_leftSp);
         addToContent(_desTxt);
         titleText = LanguageMgr.GetTranslation("planeCrisis.reportTitle");
         _contentTitleTxt.text = LanguageMgr.GetTranslation("planeCrisis.contentTitle");
         _linkTxt.text = LanguageMgr.GetTranslation("planeCrisis.lookTip");
      }
      
      private function initRewards(param1:Array, param2:int) : void
      {
         var _loc3_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc7_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:int = int(param1.length);
         _rewardBox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc7_ = param1[_loc5_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc7_[0];
            _loc6_.count = Math.ceil(_loc7_[1] * (100 - param2) / 100);
            _loc3_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc3_.data = _loc6_;
            _rewardBox.addChild(_loc3_);
            _loc5_++;
         }
         _rewardBox.commitChanges();
      }
      
      private function initPlayers(param1:Array) : void
      {
         var _loc2_:PlaneCrisisReportPItem = null;
         _playerBox.beginChanges();
         for each(var _loc3_:PlaneCrisisGameOverPlayInfo in param1)
         {
            _loc2_ = new PlaneCrisisReportPItem();
            _loc2_.data = _loc3_;
            _playerBox.addChild(_loc2_);
         }
         _playerBox.commitChanges();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _linkTxt.addEventListener("click",lookRewardHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _linkTxt.removeEventListener("click",lookRewardHandler);
      }
      
      private function lookRewardHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            ObjectUtils.disposeObject(_tipView);
            _tipView = null;
            return;
         }
         _tipView = new PlaneCrisisRewardTipView();
         var _loc2_:Point = new Point();
         _loc2_ = _linkTxt.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x - _tipView.displayWidth + 410;
         _tipView.y = _loc2_.y - 234;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
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
      
      public function show(param1:Object) : void
      {
         NumberViewUtils.getNumberView(param1.count,_leftSp,_leftActionNumData,34,45,32,34,"0123456789",1);
         _leftSp.x = 195 + (320 - _leftSp.width) * 0.5;
         _leftSp.y = 37;
         initRewards(param1.rewards,param1.rewardDelRate);
         initPlayers(param1.players);
         _desTxt.text = LanguageMgr.GetTranslation("planeCrisis.reportRewardTip",param1.buyCount,param1.diamondBuyCount,param1.rewardDelRate);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         ObjectUtils.disposeObject(_playerBox);
         _playerBox = null;
         ObjectUtils.disposeObject(_contentTitleTxt);
         _contentTitleTxt = null;
         ObjectUtils.disposeObject(_linkTxt);
         _linkTxt = null;
         ObjectUtils.disposeObject(_leftActionNumData);
         _leftActionNumData = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_leftSp);
         _leftSp = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         super.dispose();
      }
   }
}

