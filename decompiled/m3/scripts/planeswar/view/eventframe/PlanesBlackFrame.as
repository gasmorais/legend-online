package planeswar.view.eventframe
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.info.PlanesEventInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.PlanesEventsTemplateInfo;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   
   public class PlanesBlackFrame extends PlanesEventBaseFrame
   {
      
      private var titleImage:Image;
      
      private var eventBg:ScaleBitmapImage;
      
      private var eventIcon:Image;
      
      private var goodsHbox:HBox;
      
      private var eventInfo:PlanesEventInfo;
      
      private var eventTempInfo:PlanesEventsTemplateInfo;
      
      private var itemList:Vector.<PlanesBlackItemView>;
      
      public function PlanesBlackFrame()
      {
         super();
         initView();
         addEvent();
         refreshView(null);
      }
      
      private function initView() : void
      {
         titleImage = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.titleBg");
         eventIcon = ComponentFactory.Instance.creatComponentByStylename("PlanesBlackFrame.eventIcon");
         eventBg = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.eventBg");
         goodsHbox = ComponentFactory.Instance.creatComponentByStylename("planesEventFrame.goodsHbox");
         addToContent(titleImage);
         addToContent(eventIcon);
         addToContent(eventBg);
         addToContent(goodsHbox);
         itemList = new Vector.<PlanesBlackItemView>();
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_MARKETOP_BACK",refreshView);
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_MARKETOP_BACK",refreshView);
      }
      
      private function refreshView(param1:PlanesWarEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:PlanesBlackItemView = null;
         eventInfo = PlanesWarManager.instance.model.planesWarInfo.eventInfo;
         eventTempInfo = TempleteManager.instance.planesEventsTemplateCate.getTemplateByID(eventInfo.eventId);
         if(!eventInfo || !eventTempInfo)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("planeswar.view.eventframe.PlanesBlackFrame.noBuyAlert"));
            dispose();
            return;
         }
         var _loc3_:Array = eventTempInfo.Parameter.split("|");
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc5_].split(",");
            _loc2_ = _loc5_ < itemList.length ? itemList[_loc5_] : null;
            if(_loc2_ == null)
            {
               _loc2_ = new PlanesBlackItemView();
               itemList[_loc5_] = _loc2_;
               goodsHbox.addChild(_loc2_);
            }
            _loc2_.index = _loc5_;
            _loc2_.dataArr = _loc4_;
            _loc2_.isCanBuy = int(eventInfo.params[_loc5_]) == 1 ? false : true;
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(titleImage)
         {
            ObjectUtils.disposeObject(titleImage);
         }
         titleImage = null;
         if(eventBg)
         {
            ObjectUtils.disposeObject(eventBg);
         }
         eventBg = null;
         if(eventBg)
         {
            ObjectUtils.disposeObject(eventBg);
         }
         eventBg = null;
         if(goodsHbox)
         {
            ObjectUtils.disposeObject(goodsHbox);
         }
         goodsHbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

