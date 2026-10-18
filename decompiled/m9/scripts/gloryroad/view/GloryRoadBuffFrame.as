package gloryroad.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.GloryroadManager;
   import mvc.module.gloryroad.GloryRoadModel;
   import yishi.datas.ComponentGroupType;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SharedManagerHelper;
   import yishi.view.base.PageList;
   import yishi.view.base.TokenAmountItem;
   
   public class GloryRoadBuffFrame extends GloryRoadView
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:PageList;
      
      private var _leftBmp:Bitmap;
      
      private var _leftToken:TokenAmountItem;
      
      private var _nextBtn:IconButton;
      
      private var _refreshTxt:FilterFrameText;
      
      public function GloryRoadBuffFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("GloryRoadBuffFrame.initView.title");
         _bg = addCreatComponentByStylename("gloryroad.buffViewBg");
         _list = addCreatComponentByStylename("gloryroad.buffList");
         _leftBmp = addCreatBitmap("asset.gloryroad.buffLeftTxt");
         _leftToken = addCreatComponentByStylename("gloryroad.buffStarLeftToken");
         _nextBtn = addCreatComponentByStylename("gloryroad.nextBuffBtn");
         _refreshTxt = addCreatComponentByStylename("gloryroad.nextRefreshTxt");
         __refreshView(null);
      }
      
      override protected function initEvent() : void
      {
         addEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         addEvent(_nextBtn,"click",__refreshHandler);
         super.initEvent();
      }
      
      override protected function removeEvent() : void
      {
         deleteEvent(GloryroadManager.instance,"GLORY_ROAD_DATA_UPDATE",__refreshView);
         deleteEvent(_nextBtn,"click",__refreshHandler);
         super.removeEvent();
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         GloryroadManager.instance.refreshBuff();
      }
      
      private function get refreshCount() : int
      {
         return GloryroadManager.instance.model.buyBufferTimes;
      }
      
      public function __refreshView(param1:Event) : void
      {
         var _loc3_:GloryRoadModel = GloryroadManager.instance.model;
         _list.data = _loc3_.getBuffListData();
         _leftToken.firstText = _loc3_.buffStar.toString();
         var _loc4_:Boolean = false;
         var _loc2_:int = 395;
         if(_loc3_.showAfterJumper)
         {
            _loc4_ = true;
            _loc2_ = 465;
            _refreshTxt.text = LanguageMgr.GetTranslation("GloryRoadBuffFrame.refreshView.refreshTxt",refreshCount);
         }
         _nextBtn.visible = _loc4_;
         _refreshTxt.visible = _loc4_;
         this.height = _loc2_;
         if(refreshCount <= 0)
         {
            _nextBtn.enable = false;
         }
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         __refreshView(null);
      }
      
      override protected function __frameResponse(param1:FrameEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc3_ = LanguageMgr.GetTranslation("GloryRoadBuffFrame.frameResponse.alert");
            SharedManagerHelper.ins.needAlert("GloryRoadBuffFrame.close.alert",suerHandler,_loc2_,_loc3_);
         }
      }
      
      private function suerHandler() : void
      {
         var _loc1_:GloryRoadModel = GloryroadManager.instance.model;
         _loc1_.showAfterJumper = false;
         if(!_loc1_.isBuffJumper)
         {
            GloryroadManager.instance.model.viewSate = 0;
         }
         GloryroadManager.instance.dispatchEvent(new NotificationEvent("GLORY_ROAD_DATA_UPDATE"));
         dispose();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_leftBmp);
         _leftBmp = null;
         ObjectUtils.disposeObject(_leftToken);
         _leftToken = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_refreshTxt);
         _refreshTxt = null;
         super.dispose();
      }
   }
}

