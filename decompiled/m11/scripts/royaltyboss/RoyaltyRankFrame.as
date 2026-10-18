package royaltyboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.royaltyboss.RoyaltyBossModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.RoyaltyBossManager;
   
   public class RoyaltyRankFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _royaltyLevelTxt:FilterFrameText;
      
      private var _bossLevelTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _btn:IconButton;
      
      public function RoyaltyRankFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,575,510);
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("royaltyRankFrame.titleText");
         _bg = ComponentFactory.Instance.creatBitmap("asset.RoyaltyRankFrame.bg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.rankTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.nameTxt");
         _royaltyLevelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.royaltyLevelTxt");
         _bossLevelTxt = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.bossLevelTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.scrollPanel");
         _vBox = ComponentFactory.Instance.creatCustomObject("royaltyRankFrame.vBox");
         _btn = ComponentFactory.Instance.creatComponentByStylename("royaltyRankFrame.btn");
         addToContent(_bg);
         addToContent(_rankTxt);
         addToContent(_nameTxt);
         addToContent(_royaltyLevelTxt);
         addToContent(_bossLevelTxt);
         addToContent(_scrollPanel);
         addToContent(_btn);
         _scrollPanel.setView(_vBox);
         _rankTxt.text = LanguageMgr.GetTranslation("royaltyRankFrame.rankTxt.text");
         _nameTxt.text = LanguageMgr.GetTranslation("royaltyRankFrame.nameTxt.text");
         _royaltyLevelTxt.text = LanguageMgr.GetTranslation("royaltyRankFrame.royaltyLevelTxt.text");
         _bossLevelTxt.text = LanguageMgr.GetTranslation("royaltyRankFrame.bossLevelTxt.text");
         refreshView();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",__btnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btn.removeEventListener("click",__btnClickHandler);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function refreshView() : void
      {
         var _loc1_:RoyaltyRankItem = null;
         var _loc3_:int = 0;
         _vBox.removeAllChild();
         _vBox.beginChanges();
         var _loc2_:int = int(model.rankList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new RoyaltyRankItem();
            _loc1_.data = model.rankList[_loc3_];
            _vBox.addChild(_loc1_);
            _loc3_++;
         }
         _vBox.commitChanges();
         _scrollPanel.invalidateViewport();
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
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get model() : RoyaltyBossModel
      {
         return RoyaltyBossManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_royaltyLevelTxt);
         _royaltyLevelTxt = null;
         ObjectUtils.disposeObject(_bossLevelTxt);
         _bossLevelTxt = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

