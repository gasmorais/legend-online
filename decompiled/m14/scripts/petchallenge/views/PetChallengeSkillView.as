package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetChallengeSkillView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      private var _index:int;
      
      private var _data:SkillTempInfo;
      
      public function PetChallengeSkillView(param1:int = 1)
      {
         _index = param1;
         super();
         initView();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("PetChallengeSkillView.ItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("PetChallengeSkillView.SkillBookIcon");
         addChild(_back);
         addChild(_icon);
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         var _loc2_:String = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = IconFactory.getCommonIconPath(_data.Icons);
            if(_icon.icon != _loc2_)
            {
               _icon.icon = _loc2_;
            }
            this.tipData = _data;
         }
         else
         {
            _icon.icon = null;
            this.tipData = null;
         }
      }
      
      public function setIconSize(param1:int, param2:int) : void
      {
         if(_icon)
         {
            _icon.beginChanges();
            _icon.iconWidth = param1;
            _icon.iconHeight = param2;
            _icon.commitChanges();
         }
         this.width = param1;
         this.height = param2;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      override public function dispose() : void
      {
         uintView();
         super.dispose();
         _data = null;
      }
   }
}

