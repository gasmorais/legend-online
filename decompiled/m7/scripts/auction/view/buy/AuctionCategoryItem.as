package auction.view.buy
{
   import com.pickgliss.events.ComponentEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import mvc.module.auction.CategoryVO;
   import yishi.filter.UIFilter;
   
   public class AuctionCategoryItem extends Sprite implements Disposeable
   {
      
      private var _titleBtn:SelectedButton;
      
      private var _subContent:AuctionCategorySubComp;
      
      private var _selected:Boolean;
      
      private var _height:Number = 31;
      
      private var _vo:CategoryVO;
      
      private var _tipTxt:FilterFrameText;
      
      public function AuctionCategoryItem()
      {
         super();
      }
      
      public function setData(param1:CategoryVO, param2:Array) : void
      {
         _vo = param1;
         _titleBtn = ComponentFactory.Instance.creatComponentByStylename("asset.auction.CategoryBigItemBtn" + (param1.Type + 1));
         addChild(_titleBtn);
         if(param2 && param2.length > 0)
         {
            _subContent = new AuctionCategorySubComp();
            _subContent.x = 0;
            _subContent.y = 35;
            _subContent.setData(param2);
         }
         _tipTxt = ComponentFactory.Instance.creatComponentByStylename("AuctionCategoryPane.OpenPetTipTxt");
         addChild(_tipTxt);
      }
      
      public function enableAndShowTip(param1:String) : void
      {
         _tipTxt.text = param1;
         _titleBtn.filters = [UIFilter.getGrayFilter()];
         _subContent.filters = [UIFilter.getGrayFilter()];
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _titleBtn.selected = _selected;
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         _titleBtn.selected = _selected;
         if(_selected)
         {
            if(_subContent)
            {
               if(!_subContent.parent)
               {
                  addChild(_subContent);
               }
               _subContent.setSelectByIndex(0);
               changeHeight(true);
            }
         }
         else if(_subContent && _subContent.parent)
         {
            removeChild(_subContent);
            changeHeight(false);
         }
      }
      
      private function changeHeight(param1:Boolean) : void
      {
         if(!param1)
         {
            _height = 31;
         }
         else
         {
            _height = super.height;
         }
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["height"] = true;
         dispatchEvent(new ComponentEvent("propertiesChanged",_loc2_));
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function getData() : CategoryVO
      {
         return _vo;
      }
      
      public function getSubSelectedVo() : CategoryVO
      {
         if(_subContent)
         {
            if(_subContent.getSelectItem())
            {
               return _subContent.getSelectItem().getData();
            }
         }
         return null;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_titleBtn);
         _titleBtn = null;
         ObjectUtils.disposeObject(_subContent);
         _subContent = null;
         if(_tipTxt)
         {
            _tipTxt.dispose();
         }
         _tipTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

