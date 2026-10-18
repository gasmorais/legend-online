package map.campaign.view.ui.emedream
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class EmeDreamSkillView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      private var _index:int;
      
      private var _data:SkillTempInfo;
      
      public function EmeDreamSkillView(param1:int = 1)
      {
         super();
         _index = param1;
         initView();
         addEvent();
         this.mouseChildren = false;
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("warlordsroom.WarlordsSkillView.ItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("warlordsroom.WarlordsSkillView.SkillBookIcon");
         addChild(_back);
         addChild(_icon);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
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

