package pet.equipstore
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class NeedMaterialItem extends Sprite implements Disposeable
   {
      
      private var _item:BaseItemView;
      
      private var _txt:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      private var _needItemNum:int;
      
      public function NeedMaterialItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("pet.needMaterialItem");
         _txt = ComponentFactory.Instance.creatComponentByStylename("pet.needMaterialItemTxt");
         addChild(_item);
         addChild(_txt);
         _txt.setFrame(1);
         _txt.text = "100/20";
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _item.data = param1;
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set needItemNum(param1:int) : void
      {
         _needItemNum = param1;
      }
      
      public function get needItemNum() : int
      {
         return _needItemNum;
      }
      
      public function updateTxt(param1:int) : void
      {
         if(!_data)
         {
            return;
         }
         if(needItemNum <= 0)
         {
            return;
         }
         _txt.text = param1 + "/" + needItemNum;
         if(param1 >= needItemNum)
         {
            _txt.setFrame(2);
         }
         else
         {
            _txt.setFrame(1);
         }
      }
      
      public function txtVisible(param1:Boolean) : void
      {
         _txt.visible = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

