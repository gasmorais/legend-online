package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaTalismanSelectItem;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaTalismanView extends Component
   {
      
      private var _title:Image;
      
      private var _back:ScaleBitmapImage;
      
      private var _line:Image;
      
      private var _talismanHbox:HBox;
      
      private var talismanList:Vector.<DreamArenaTalismanSelectItem>;
      
      public function DreamArenaTalismanView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         _title = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.title");
         _back = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.back");
         _line = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaTalismanView.line");
         _talismanHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaTalismanView.talismanHbox");
         addChild(_back);
         addChild(_line);
         addChild(_title);
         addChild(_talismanHbox);
      }
      
      private function initListView() : void
      {
         var _loc3_:DreamArenaTalismanSelectItem = null;
         var _loc1_:int = 0;
         talismanList = new Vector.<DreamArenaTalismanSelectItem>();
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(8);
         _loc1_ = 0;
         while(_loc1_ < _loc2_.length)
         {
            _loc3_ = new DreamArenaTalismanSelectItem(_loc1_ + 1);
            _loc3_.data = _loc2_[_loc1_];
            _talismanHbox.addChild(_loc3_);
            talismanList.push(_loc3_);
            _loc1_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc3_:DreamArenaTalismanSelectItem = null;
         var _loc1_:int = 0;
         var _loc2_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(8);
         _loc1_ = 0;
         while(_loc1_ < talismanList.length)
         {
            _loc3_ = talismanList[_loc1_];
            _loc3_.data = _loc2_[_loc1_];
            _loc1_++;
         }
      }
      
      public function refreshClientSelect() : void
      {
         var _loc2_:DreamArenaTalismanSelectItem = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < talismanList.length)
         {
            _loc2_ = talismanList[_loc1_];
            _loc2_.refreshClientSelect();
            _loc1_++;
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
         ObjectUtils.disposeObject(_talismanHbox);
         _talismanHbox = null;
         LogicUtils.disposeDisplayCollection(talismanList);
         talismanList = null;
         super.dispose();
      }
   }
}

