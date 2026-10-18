package yishi.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.utils.GoodsHelp;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class BaseBoxGoodsItem extends Sprite implements Disposeable
   {
      
      public static const DIRECTION_DOWN:int = 1;
      
      public static const DIRECTION_RIGHT:int = 2;
      
      private var _icon:BaseItemView;
      
      private var _name:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      private var _direction:int;
      
      public function BaseBoxGoodsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("core.BoxGoodsItem");
         _name = ComponentFactory.Instance.creatComponentByStylename("core.BoxGoodsItemText");
         addChild(_icon);
         addChild(_name);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _icon.data = _data;
         var _loc2_:GoodsTemplateInfo = param1.templateInfo;
         if(_data && _loc2_)
         {
            _name.htmlText = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc2_.Profile),_loc2_.TemplateName);
            switch(_direction - 2)
            {
               case 0:
                  _name.autoSize = "left";
                  _name.x = _icon.x + _icon.displayWidth + 5;
                  _name.y = _icon.y + (_icon.displayHeight - _name.height) / 2;
                  break;
               default:
                  if(_name.width < _icon.displayWidth)
                  {
                     _name.x = _icon.x + (_icon.displayWidth - _name.width) / 2;
                  }
                  else
                  {
                     _icon.x = _name.x + (_name.width - _icon.displayWidth) / 2;
                  }
                  _name.y = _icon.y + _icon.displayHeight - 3;
            }
         }
      }
      
      public function get direction() : int
      {
         return _direction;
      }
      
      public function set direction(param1:int) : void
      {
         _direction = param1;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
   }
}

