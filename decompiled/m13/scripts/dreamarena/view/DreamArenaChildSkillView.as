package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.component.TileContainer;
   
   public class DreamArenaChildSkillView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _itemList:TileContainer;
      
      private var col:int = 5;
      
      private var showCount:int = 10;
      
      public function DreamArenaChildSkillView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArenaChildSkillView.back");
         _itemList = ComponentFactory.Instance.creatCustomObject("DreamArenaChildSkillView.TileContainer");
         addChild(_back);
         addChild(_itemList);
         _back.mouseChildren = _back.mouseEnabled = false;
      }
      
      public function show(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc5_:SkillTempInfo = null;
         var _loc3_:BaseIconView = null;
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < showCount)
         {
            _loc2_ = int(param1[_loc4_] ? param1[_loc4_] : 0);
            _loc5_ = TempleteManager.instance.skillTemplateDic[_loc2_];
            _loc3_ = ComponentFactory.Instance.creatCustomObject("DreamArenaChildSkillView.skillIcon");
            if(_loc5_)
            {
               _loc3_.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
               _loc3_.tipData = _loc5_;
            }
            _itemList.appendItem(_loc3_);
            _loc4_++;
         }
         LayerManager.Instance.addToLayer(this,7);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

