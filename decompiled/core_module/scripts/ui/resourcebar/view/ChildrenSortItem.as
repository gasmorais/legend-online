package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class ChildrenSortItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _overbg:DisplayObject;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _data:ChildData;
      
      private var _strip:StripView;
      
      private var _childType:int;
      
      public var itemClickHandler:Function;
      
      public function ChildrenSortItem(param1:int)
      {
         super();
         _childType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _overbg = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.ItemOver");
         _icon = ComponentFactory.Instance.creatCustomObject("resoueceBar.PetIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetItemName");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetItemGrade");
         _strip = ComponentFactory.Instance.creatCustomObject("resourceBar.ChildrenIconStrip");
         addChild(_overbg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         _strip.setHitArea(0,3,160,32);
         _strip.tipGapH = -5;
         addChild(_strip);
         _overbg.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("rollOver",mouseOverHandler);
         this.addEventListener("rollOut",mouseOutHandler);
         this.addEventListener("click",mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOver",mouseOverHandler);
         this.removeEventListener("rollOut",mouseOutHandler);
         this.removeEventListener("click",mouseClickHandler);
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         _overbg.visible = true;
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         _overbg.visible = false;
      }
      
      private function mouseClickHandler(param1:MouseEvent) : void
      {
         if(itemClickHandler != null)
         {
            itemClickHandler(_data.childId,_childType);
         }
         else
         {
            ChildSender.setEnterWar(_data.childId,_childType);
         }
         LayerManager.Instance.clearGameMenuLayer();
      }
      
      public function get data() : ChildData
      {
         return _data;
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         var _loc3_:String = _loc1_.JobName;
         _nameTxt.text = _loc3_;
         _nameTxt.setFrame(2);
         if(_nameTxt.numLines > 1)
         {
            _nameTxt.y = 0;
            _nameTxt.height = 35;
         }
         else
         {
            _nameTxt.y = 10;
            _nameTxt.height = 22;
         }
         _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",_data.growthGrade);
         var _loc2_:String = PathManager.info.ResourcePath + "icon" + _loc1_.Icon;
         if(_icon.icon != _loc2_)
         {
            _icon.icon = _loc2_;
         }
         _strip.tipData = _data;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_overbg);
         _overbg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_strip);
         _strip = null;
         _data = null;
         itemClickHandler = null;
         super.dispose();
      }
   }
}

