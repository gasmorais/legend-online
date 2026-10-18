package braveleg.team
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.manager.BraveLegManager;
   import yishi.manager.TempleteManager;
   
   public class BraveLegSkillSelectView extends Component
   {
      
      public static const SKILL:Array = [9010,9020,9030];
      
      private var _bg:ScaleBitmapImage;
      
      private var _hBox:HBox;
      
      private var _skill:Vector.<BraveLegSkillItemView>;
      
      private var _groupId:int;
      
      private var _skillId:int;
      
      public function BraveLegSkillSelectView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc1_:BraveLegSkillItemView = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillBg");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillHBox");
         addChild(_bg);
         addChild(_hBox);
         _bg.mouseChildren = _bg.mouseEnabled = false;
         _hBox.mouseEnabled = false;
         _skill = new Vector.<BraveLegSkillItemView>();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("braveleg.SkillItem");
            _skill.push(_loc1_);
            _hBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         this.addEventListener("click",__mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",__mouseClickHandler);
      }
      
      public function show(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:int = 0;
         _groupId = param1;
         _skillId = param2;
         param3 = Math.max(param3,1);
         _loc4_ = 0;
         while(_loc4_ < _skill.length)
         {
            _skill[_loc4_].data = TempleteManager.instance.getChildSkillsByMasterTypeAndGrades(SKILL[_loc4_],param3)[0];
            _loc4_++;
         }
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:BraveLegSkillItemView = param1.target as BraveLegSkillItemView;
         if(_loc2_ && _loc2_.data)
         {
            if(_skillId != _loc2_.data.TemplateId)
            {
               BraveLegManager.instance.requestChangeInspire(_groupId,_loc2_.data.MasterType);
            }
            param1.stopImmediatePropagation();
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         if(_skill)
         {
            while(_skill.length)
            {
               ObjectUtils.disposeObject(_skill.pop());
            }
            _skill = null;
         }
         super.dispose();
      }
   }
}

