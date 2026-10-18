package proficiency
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.ProficiencyManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ProficiencyExchangeFrame extends Frame
   {
      
      private var _back:MutipleImage;
      
      private var _descText:FilterFrameText;
      
      private var _hbox:HBox;
      
      private var _exchangeBtn:IconButton;
      
      public function ProficiencyExchangeFrame()
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
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,390,360);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("ProficiencyExchangeFrame.back");
         _descText = ComponentFactory.Instance.creatComponentByStylename("ProficiencyExchangeFrame.descText");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ProficiencyExchangeFrame.hbox");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("ProficiencyExchangeFrame.exchangeBtn");
         addToContent(_back);
         addToContent(_descText);
         addToContent(_hbox);
         addToContent(_exchangeBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _exchangeBtn.addEventListener("click",__exchangeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_exchangeBtn)
         {
            _exchangeBtn.removeEventListener("click",__exchangeBtnClickHandler);
         }
      }
      
      private function __exchangeBtnClickHandler(param1:MouseEvent) : void
      {
         ProficiencyManager.instance.sendProficiencyRequest(1);
         dispose();
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc4_:int = 0;
         _hbox.removeAllChild();
         var _loc5_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(627);
         _loc5_.sortOn("TemplateId",16);
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc3_ = _loc5_[_loc4_];
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ProficiencyExchangeFrame.exchangeItem");
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc3_.TemplateId;
            _loc6_.count = GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc3_.TemplateId);
            _loc2_.data = _loc6_;
            _hbox.addChild(_loc2_);
            if(_loc6_.count == 0)
            {
               _loc2_.setItemTextOther("0");
            }
            _loc7_ += _loc6_.count;
            _loc1_ += _loc6_.count * _loc3_.Property1;
            _loc4_++;
         }
         _exchangeBtn.enable = _loc7_ > 0;
         _descText.htmlText = LanguageMgr.GetTranslation("ProficiencyExchangeFrame.descText.text",_loc1_);
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
         this.titleText = LanguageMgr.GetTranslation("ProficiencyExchangeFrame.title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         super.dispose();
      }
   }
}

