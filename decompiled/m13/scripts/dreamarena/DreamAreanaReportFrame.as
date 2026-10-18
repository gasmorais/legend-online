package dreamarena
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class DreamAreanaReportFrame extends Frame
   {
      
      private var _bg:MutipleImage;
      
      private var _winCon:Component;
      
      private var _loseCon:Component;
      
      private var _winNum:BitmapData;
      
      private var _loseNum:BitmapData;
      
      private var _sureBtn:IconButton;
      
      private var _rewardBox:HBox;
      
      public function DreamAreanaReportFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaReportFrame.bg");
         _winCon = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaReportFrame.winCon");
         _loseCon = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaReportFrame.loseCon");
         _winNum = ComponentFactory.Instance.creatBitmapData("asset.DreamAreanaReportFrame.winNum");
         _loseNum = ComponentFactory.Instance.creatBitmapData("asset.DreamAreanaReportFrame.LoseNum");
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaReportFrame.sureBtn");
         _rewardBox = ComponentFactory.Instance.creatComponentByStylename("DreamAreanaReportFrame.rewardHbox");
         addToContent(_bg);
         addToContent(_winCon);
         addToContent(_loseCon);
         addToContent(_rewardBox);
         addToContent(_sureBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sureBtn.addEventListener("click",__sureClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__sureClickHandler);
         }
      }
      
      private function __sureClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CommonDropTempInfo = null;
         var _loc5_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         NumberViewUtils.refreshValue(model.winCount,_winCon,_winNum,25,34,18,25,"0123456789");
         NumberViewUtils.refreshValue(model.loseCount,_loseCon,_loseNum,25,34,18,25,"0123456789");
         _winCon.x = model.winCount >= 10 ? 140 : 157;
         _rewardBox.removeAllChild();
         var _loc4_:Array = TempleteManager.instance.dreamArenaRewardTempCate.getWinCountTemplatesDic()[model.winCount];
         if(_loc4_ == null || _loc4_.length <= 0)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc2_];
            _loc5_ = ComponentFactory.Instance.creatCustomObject("DreamAreanaReportFrame.rewardItem");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc1_.itemId;
            _loc3_.count = _loc1_.count;
            _loc5_.data = _loc3_;
            _rewardBox.addChild(_loc5_);
            _loc2_++;
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("DreamAreanaReportFrame.titleText.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         model.reportData = null;
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_winCon);
         _winCon = null;
         ObjectUtils.disposeObject(_loseCon);
         _loseCon = null;
         ObjectUtils.disposeObject(_winNum);
         _winNum = null;
         ObjectUtils.disposeObject(_loseNum);
         _loseNum = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         ObjectUtils.disposeObject(_rewardBox);
         _rewardBox = null;
         super.dispose();
      }
   }
}

