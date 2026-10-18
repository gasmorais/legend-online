package yishi.view.tips.goods
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.monster.MonsterModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MonsterManager;
   
   public class MonsterAccessoriesTipsItem extends Component
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _txt:FilterFrameText;
      
      private var _filter:IFilterFormat;
      
      private var _index:int;
      
      private var _data:SkillTempInfo;
      
      public function MonsterAccessoriesTipsItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatComponentByStylename("tips.MonsterAccessoriesTipsItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("tips.MonsterAccessoriesTipsItem.txt");
         addChild(_icon);
         _icon.setFrame(1);
         addChild(_txt);
         _txt.setFrame(1);
         _filter = new UIFilter();
         _filter.setGrayFilter(this);
         _txt.text = LanguageMgr.GetTranslation("MonsterAccessoriesEffectItem.txt.text",getGrades(_index));
         _txt.setFrame(1);
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(!param1)
         {
            _icon.setFrame(1);
            _filter.setGrayFilter(this);
            _txt.text = LanguageMgr.GetTranslation("MonsterAccessoriesEffectItem.txt.text",getGrades(_index));
            _txt.setFrame(1);
         }
         else
         {
            _filter.setNormalFilter(this);
            _txt.text = LanguageMgr.GetTranslation("MonsterAccessoriesEffectItem.txt.text2",_data.TemplateName,_data.Grades);
            _txt.setFrame(_data.Grades);
         }
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function get icon() : ScaleFrameImage
      {
         return _icon;
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      private function getGrades(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:Array = MonsterManager.instance.model.accessoriesUpgradeTempAry;
         for each(var _loc4_:UpgradeTemplateInfo in _loc2_)
         {
            if(_loc4_.ActiveObject == param1)
            {
               _loc3_ = _loc4_.Grades;
               break;
            }
         }
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

