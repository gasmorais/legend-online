package darkmaze
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import managers.DarkMazeManager;
   import mvc.module.children.ChildData;
   import mvc.module.darkmaze.DarkMazeBattleChildInfo;
   import mvc.module.darkmaze.DarkMazeModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class DarkMazeCommonItemView extends Component
   {
      
      private var _borderBg:Image;
      
      private var _iconView:BaseIconView;
      
      private var _hpMaxImg:Image;
      
      private var _hpMinImg:Image;
      
      private var _data:DarkMazeBattleChildInfo;
      
      private var _mask:Shape;
      
      private var _currentHp:int;
      
      private var _totalHp:int;
      
      private var _childData:ChildData;
      
      public function DarkMazeCommonItemView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _borderBg = ComponentFactory.Instance.creatComponentByStylename("darkMazeCommonItemView.borderBg");
         _iconView = ComponentFactory.Instance.creatCustomObject("darkMazeCommonItemView.iconView");
         _hpMaxImg = ComponentFactory.Instance.creatComponentByStylename("darkMazeCommonItemView.hpMaxImg");
         _hpMinImg = ComponentFactory.Instance.creatComponentByStylename("darkMazeCommonItemView.hpMinImg");
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_hpMaxImg.width,_hpMaxImg.height);
         _mask.graphics.endFill();
         _mask.x = _hpMaxImg.x;
         _mask.y = _hpMaxImg.y;
         _hpMaxImg.mask = _mask;
         addChild(_borderBg);
         addChild(_iconView);
         addChild(_hpMinImg);
         addChild(_hpMaxImg);
         addChild(_mask);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_borderBg);
         _borderBg = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_hpMaxImg);
         _hpMaxImg = null;
         ObjectUtils.disposeObject(_hpMinImg);
         _hpMinImg = null;
      }
      
      public function set totalHp(param1:int) : void
      {
         _totalHp = param1;
      }
      
      public function set currentHp(param1:int) : void
      {
         _currentHp = param1;
      }
      
      public function set data(param1:DarkMazeBattleChildInfo) : void
      {
         var _loc3_:ChildTempInfo = null;
         _data = param1;
         if(!_data)
         {
            return;
         }
         _childData = model.getChildDataById(param1.childId);
         if(_childData)
         {
            _loc3_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_childData.job,_childData.growthGrade);
            if(_loc3_)
            {
               _iconView.icon = PathManager.info.ResourcePath + "icon" + _loc3_.Icon;
            }
         }
         var _loc2_:int = _hpMaxImg.width * (_totalHp - _currentHp) / _totalHp;
         _mask.x = _hpMaxImg.x - _loc2_;
      }
      
      private function get model() : DarkMazeModel
      {
         return DarkMazeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

