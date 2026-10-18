package monopoly.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignNodeInfoMsg;
   import com.road.yishi.proto.campaign.TempMsg;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   
   public class MonopolyGameOverFrame extends Frame implements IManualSize
   {
      
      private var _rect:Rectangle;
      
      private var _scaleBg:ScaleBitmapImage;
      
      private var _contentBg:Image;
      
      private var _resultImg:ScaleFrameImage;
      
      private var _contentScroll:ScrollPanel;
      
      private var _contentContainer:Sprite;
      
      private var _contentTxt:FilterFrameText;
      
      private var _itemContainer:SimpleTileList;
      
      private var _confirmBtn:IconButton;
      
      private var _data:CampaignNodeInfoMsg;
      
      public function MonopolyGameOverFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(!_rect)
         {
            _rect = new Rectangle(0,0,433,338);
         }
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["POPUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("monopoly.view.MonopolyGameOverFrame.TitleTxt");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ScaleBg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ContentBg");
         _resultImg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ResultImg");
         _contentScroll = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ContentScroll");
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ContentTxt");
         _itemContainer = ComponentFactory.Instance.creatCustomObject("monopoly.MonopolyGameOverFrame.ItemContainer",[2]);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ConfirmBtn");
         _contentContainer = new Sprite();
         _itemContainer.align = "align_left";
         _contentContainer.addChild(_contentTxt);
         _contentContainer.addChild(_itemContainer);
         _contentScroll.setView(_contentContainer);
         addToContent(_scaleBg);
         addToContent(_contentBg);
         addToContent(_resultImg);
         addToContent(_contentScroll);
         addToContent(_confirmBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_contentContainer);
         ObjectUtils.disposeAllChildren(_itemContainer);
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeObject(_contentBg);
         _contentBg = null;
         ObjectUtils.disposeObject(_resultImg);
         _resultImg = null;
         ObjectUtils.disposeObject(_contentScroll);
         _contentScroll = null;
         ObjectUtils.disposeObject(_contentContainer);
         _contentContainer = null;
         ObjectUtils.disposeObject(_contentTxt);
         _contentTxt = null;
         ObjectUtils.disposeObject(_itemContainer);
         _itemContainer = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",__confirmBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",__confirmBtnClickHandler);
      }
      
      private function __confirmBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function refresh() : void
      {
         var _loc1_:GoodsTemplateInfo = null;
         var _loc3_:FilterFrameText = null;
         if(_data)
         {
            if(_data.type == 1)
            {
               _resultImg.setFrame(2);
            }
            else
            {
               _resultImg.setFrame(1);
            }
            _contentTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyGameOverFrame.ContentTxt");
            for each(var _loc2_:TempMsg in _data.nodeInfo)
            {
               _loc1_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.templateId);
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyGameOverFrame.ItemTxt");
               _loc3_.text = _loc1_.TemplateName + "*" + _loc2_.count;
               _loc3_.setFrame(_loc1_.Profile);
               _itemContainer.addChild(_loc3_);
            }
            _contentScroll.invalidateViewport();
            if(_contentContainer.height <= 96)
            {
               _contentScroll.vScrollbar.visible = false;
            }
         }
      }
      
      public function set data(param1:CampaignNodeInfoMsg) : void
      {
         _data = param1;
         refresh();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

