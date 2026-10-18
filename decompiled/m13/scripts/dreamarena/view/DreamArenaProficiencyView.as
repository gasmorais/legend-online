package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaCommonSelectItem;
   import utils.LogicUtils;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaProficiencyView extends Component
   {
      
      private var _title:Image;
      
      private var _back:ScaleBitmapImage;
      
      private var _line:Image;
      
      private var _proficiencyHbox:HBox;
      
      private var proficiencyList:Vector.<DreamArenaCommonSelectItem>;
      
      public function DreamArenaProficiencyView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.back");
         _line = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaProficiencyView.line");
         _proficiencyHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTalismanView.proficiencyHbox");
         addChild(_back);
         addChild(_line);
         addChild(_title);
         addChild(_proficiencyHbox);
      }
      
      private function initListView() : void
      {
         var _loc2_:DreamArenaCommonSelectItem = null;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:int = 0;
         proficiencyList = new Vector.<DreamArenaCommonSelectItem>();
         var _loc1_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc4_:Array = _loc1_.Skill3.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc5_ = TempleteManager.instance.skillTemplateDic[_loc4_[_loc3_]];
            _loc2_ = new DreamArenaCommonSelectItem(2,_loc3_ + 1);
            _loc2_.data = _loc5_;
            _proficiencyHbox.addChild(_loc2_);
            proficiencyList.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:DreamArenaCommonSelectItem = null;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:int = 0;
         var _loc1_:DreamArenaTempInfo = TempleteManager.instance.dreamArenaTempCate.getTempInfoByTypeAndId(1,0);
         var _loc4_:Array = _loc1_.Skill3.split(",");
         _loc3_ = 0;
         while(_loc3_ < proficiencyList.length)
         {
            _loc5_ = TempleteManager.instance.skillTemplateDic[_loc4_[_loc3_]];
            _loc2_ = proficiencyList[_loc3_];
            _loc2_.data = _loc5_;
            _loc3_++;
         }
      }
      
      public function refreshClientSelect() : void
      {
         var _loc1_:DreamArenaCommonSelectItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < proficiencyList.length)
         {
            _loc1_ = proficiencyList[_loc2_];
            _loc1_.refreshClientSelect();
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_title);
         _title = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_proficiencyHbox);
         _proficiencyHbox = null;
         LogicUtils.disposeDisplayCollection(proficiencyList);
         proficiencyList = null;
         super.dispose();
      }
   }
}

