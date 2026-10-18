package gemmaze.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.GemMazeEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.GemMazeManager;
   import yishi.view.community.BaseItemView;
   
   public class GemMazePrizeView extends Sprite implements Disposeable
   {
      
      private var _bg:Image;
      
      private var _title:FilterFrameText;
      
      private var _grizeGetBtn:BaseButton;
      
      private var _hBox:HBox;
      
      public var boxIndex:int;
      
      private var _isCanGet:Boolean;
      
      public var scoreIndex:int;
      
      public function GemMazePrizeView(param1:int)
      {
         super();
         this.scoreIndex = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc3_:GoodsInfo = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("GemMaze.grizeBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("GemMaze.grizeTitleTxt");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("GemMaze.grizeHbox");
         _grizeGetBtn = ComponentFactory.Instance.creatComponentByStylename("GemMaze.grizeGetBtn");
         addChild(_bg);
         addChild(_title);
         addChild(_hBox);
         addChild(_grizeGetBtn);
         _title.text = LanguageMgr.GetTranslation("gemMaze.GemMazeFrame.prizeTitle");
         var _loc4_:Array = GemMazeManager.Instance.model.dropDict[scoreIndex] as Array;
         _loc2_ = 0;
         while(_loc2_ < _loc4_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc4_[_loc2_].tempId;
            _loc3_.count = _loc4_[_loc2_].count;
            _loc3_.showCount = true;
            _loc1_.data = _loc3_;
            _hBox.addChild(_loc1_);
            _loc2_++;
         }
         _hBox.x = _bg.x + (_bg.width - _hBox.width) / 2;
      }
      
      private function addEvent() : void
      {
         _grizeGetBtn.addEventListener("click",__pickupHandler);
      }
      
      private function removeEvent() : void
      {
         _grizeGetBtn.removeEventListener("click",__pickupHandler);
      }
      
      private function onUpdateBag(param1:GemMazeEvent) : void
      {
      }
      
      private function __pickupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         GemMazeManager.Instance.getBoxGoods(boxIndex);
         dispose();
      }
      
      private function __cleanupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get isCanGet() : Boolean
      {
         return _isCanGet;
      }
      
      public function set isCanGet(param1:Boolean) : void
      {
         _isCanGet = param1;
         _grizeGetBtn.enable = _isCanGet;
      }
   }
}

