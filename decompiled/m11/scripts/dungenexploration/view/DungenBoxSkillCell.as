package dungenexploration.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.MediatorMananger;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DungenBoxSkillCell extends Sprite
   {
      
      public static const NAME:String = "thessbox.view.ThessBoxSkillCell";
      
      private var _mediatorKey:String;
      
      private var _bg:ScaleBitmapImage;
      
      private var _icon:BaseIconView;
      
      private var _registed:Boolean = false;
      
      private var _filter:IFilterFormat;
      
      private var _data:int;
      
      private var _type:int;
      
      private var _pos:int;
      
      public function DungenBoxSkillCell(param1:int = 2, param2:int = -1)
      {
         super();
         _type = param1;
         _pos = param2;
         initView();
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get pos() : int
      {
         return _pos;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.thessbox.ItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.thessbox.skBgicon");
         addChild(_bg);
         addChild(_icon);
         _filter = new UIFilter();
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [DungenBoxSkillCellClickMediator,DungenBoxSkillCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"thessbox.view.ThessBoxSkillCell");
      }
      
      private function unRegisterMediator() : void
      {
         _registed = false;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      public function dispose() : void
      {
         unRegisterMediator();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _filter = null;
      }
      
      public function setNormalFilter() : void
      {
         if(_icon)
         {
            _filter.setNormalFilter(_icon);
         }
      }
      
      public function setGrayFilter() : void
      {
         if(_icon)
         {
            _filter.setGrayFilter(_icon);
         }
      }
      
      public function get icon() : BaseIconView
      {
         return _icon;
      }
      
      public function get data() : int
      {
         return _data;
      }
      
      public function set data(param1:int) : void
      {
         var _loc2_:SkillTempInfo = null;
         _data = param1;
         if(_data > 0)
         {
            _icon.visible = true;
            _loc2_ = TempleteManager.instance.getSkillById(_data);
            _icon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
            _icon.tipData = _loc2_;
            if(_registed)
            {
            }
         }
         else
         {
            _icon.visible = false;
         }
      }
   }
}

