package auction.view.buy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.auction.CategoryVO;
   import yishi.manager.ArmyManager;
   
   [Event(name="select",type="flash.events.Event")]
   public class AuctionCategoryPane extends Sprite implements Disposeable
   {
      
      private var _scrollPane:ScrollPanel;
      
      private var _border:DisplayObject;
      
      private var _corner1:DisplayObject;
      
      private var _corner2:DisplayObject;
      
      private var _corner3:DisplayObject;
      
      private var _corner4:DisplayObject;
      
      private var _itemBox:VBox;
      
      private var _data:Array;
      
      private var _selectedItem:AuctionCategoryItem;
      
      private var _xml:XML;
      
      public function AuctionCategoryPane()
      {
         super();
         _xml = new XML(LanguageMgr.GetTranslation("AuctionCategoryPane.xml"));
         initData(_xml);
         initView();
         createView();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("auction.buy.categoryBack");
         addChild(_border);
         _itemBox = new VBox();
         _itemBox.spacing = 2;
         _scrollPane = ComponentFactory.Instance.creatComponentByStylename("auction.search.Scroll");
         _scrollPane.setView(_itemBox);
         addChild(_scrollPane);
         _corner1 = ComponentFactory.Instance.creatComponentByStylename("auction.categoryCorner1");
         _corner2 = ComponentFactory.Instance.creatComponentByStylename("auction.categoryCorner2");
         _corner3 = ComponentFactory.Instance.creatComponentByStylename("auction.categoryCorner3");
         _corner4 = ComponentFactory.Instance.creatComponentByStylename("auction.categoryCorner4");
         addChild(_corner1);
         addChild(_corner2);
         addChild(_corner3);
         addChild(_corner4);
      }
      
      private function initData(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc6_:int = 0;
         var _loc3_:XMLList = null;
         var _loc2_:Array = null;
         var _loc7_:int = 0;
         _data = [];
         _data.push([]);
         _data.push([]);
         var _loc5_:XMLList = param1..Menu;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length())
         {
            _loc4_ = _loc5_[_loc6_] as XML;
            _data[0].push(createMemberVo(_loc4_));
            _loc3_ = _loc4_.MenuItem;
            _loc2_ = [];
            _data[1][_loc6_] = _loc2_;
            _loc7_ = 0;
            while(_loc7_ < _loc3_.length())
            {
               _loc4_ = _loc3_[_loc7_] as XML;
               _loc2_.push(createMemberVo(_loc4_));
               _loc7_++;
            }
            _loc6_++;
         }
      }
      
      private function createMemberVo(param1:XML) : CategoryVO
      {
         var _loc2_:CategoryVO = new CategoryVO();
         _loc2_.MenuName = param1.@MenuName;
         _loc2_.Type = int(param1.@Type);
         return _loc2_;
      }
      
      private function createView() : void
      {
         var _loc3_:AuctionCategoryItem = null;
         var _loc5_:int = 0;
         var _loc2_:String = null;
         var _loc1_:Array = _data[0];
         var _loc4_:int = int(ArmyManager.instance.thane.grades);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = new AuctionCategoryItem();
            _loc3_.setData(_loc1_[_loc5_],_data[1][_loc5_]);
            _loc3_.addEventListener("click",onItemClick,false,0,true);
            _itemBox.addChild(_loc3_);
            if(_loc1_[_loc5_].Type == 4 && _loc4_ < 50)
            {
               _loc2_ = LanguageMgr.GetTranslation("armyII.SkillFrame.AlertMsg",50);
               _loc3_.enableAndShowTip(_loc2_);
            }
            _loc5_++;
         }
         selectItem(AuctionCategoryItem(_itemBox.getChildAt(0)));
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         selectItem(param1.currentTarget as AuctionCategoryItem);
      }
      
      private function selectItem(param1:AuctionCategoryItem) : void
      {
         if(_selectedItem == param1)
         {
            dispatchEvent(new Event("select"));
            _selectedItem.selected = true;
            return;
         }
         if(_selectedItem)
         {
            _selectedItem.selected = false;
         }
         _selectedItem = param1;
         _selectedItem.selected = true;
         _scrollPane.invalidateViewport();
         dispatchEvent(new Event("select"));
      }
      
      public function getFirstCategoryType() : int
      {
         if(_selectedItem)
         {
            return _selectedItem.getData().Type;
         }
         return 0;
      }
      
      public function getSecondCategoryType() : int
      {
         if(_selectedItem && _selectedItem.getSubSelectedVo())
         {
            return _selectedItem.getSubSelectedVo().Type;
         }
         return 0;
      }
      
      public function dispose() : void
      {
         var _loc1_:AuctionCategoryItem = null;
         while(_itemBox.numChildren > 0)
         {
            _loc1_ = _itemBox.getChildAt(0) as AuctionCategoryItem;
            if(_loc1_)
            {
               if(_loc1_.parent)
               {
                  _loc1_.parent.removeChild(_loc1_);
               }
               _loc1_.removeEventListener("click",onItemClick);
               _loc1_.dispose();
               _loc1_ = null;
            }
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

