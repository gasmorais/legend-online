package child.equip
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import managers.ChildManager;
   import mvc.module.children.ChildModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.MsgMan;
   
   public class ChildInsertEquipView extends Component
   {
      
      private var _equipBag:ChildEquipBagView;
      
      private var _bg:Image;
      
      private var _cell:ChildBagCell;
      
      private var _effectBack:MovieImage;
      
      private var _hbox:HBox;
      
      private var _list:Vector.<ChildInsetItemView>;
      
      public function ChildInsertEquipView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildInsertEquipView.bg");
         _cell = ComponentFactory.Instance.creatCustomObject("ChildInsertEquipView.item",[true]);
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ChildInsertEquipView.hbox");
         _effectBack = ComponentFactory.Instance.creatComponentByStylename("ChildInsertEquipView.EquipSelectedEff");
         _effectBack.mouseChildren = _effectBack.mouseEnabled = false;
         _effectBack.movie.stop();
         _effectBack.visible = false;
         _equipBag = new ChildEquipBagView(3,11);
         _list = new Vector.<ChildInsetItemView>();
         addChild(_bg);
         addChild(_cell);
         addChild(_effectBack);
         addChild(_hbox);
         addChild(_equipBag);
         _equipBag.x = 6;
         _equipBag.y = 258;
         _cell.bagType = 29;
         _cell.celltType = "CELL_HIDE";
         initHoleView();
      }
      
      private function initHoleView() : void
      {
         var _loc1_:ChildInsetItemView = null;
         var _loc2_:int = 0;
         _loc2_ = 1;
         while(_loc2_ < 5)
         {
            _loc1_ = new ChildInsetItemView();
            _loc1_.pos = _loc2_;
            _hbox.addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChildInsetItemView = null;
         var _loc4_:GoodsInfo = null;
         var _loc5_:int = 0;
         var _loc1_:ChildInsetItemView = null;
         var _loc6_:GoodsInfo = model.hideGoods;
         _cell.data = _loc6_;
         if(_loc6_)
         {
            _loc3_ = 0;
            while(_loc3_ < 4)
            {
               _loc2_ = _list[_loc3_] as ChildInsetItemView;
               _loc2_.data = null;
               if(_loc6_["join" + (_loc3_ + 1)] == -1)
               {
                  if(_loc3_ == 3)
                  {
                     if(_loc6_.templateInfo.Profile < 5)
                     {
                        _loc2_.state = 0;
                     }
                     else
                     {
                        _loc2_.state = 1;
                     }
                  }
                  else
                  {
                     _loc2_.state = 2;
                  }
               }
               else if(_loc6_["join" + (_loc3_ + 1)] == 0)
               {
                  _loc2_.state = 2;
               }
               else if(_loc6_["join" + (_loc3_ + 1)] > 0)
               {
                  _loc2_.state = 2;
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc6_["join" + (_loc3_ + 1)];
                  _loc2_.data = _loc4_;
               }
               else
               {
                  _loc2_.state = 3;
               }
               _loc3_++;
            }
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc1_ = _list[_loc5_] as ChildInsetItemView;
               _loc1_.data = null;
               _loc1_.state = 3;
               _loc5_++;
            }
         }
      }
      
      private function __bagItemUpdateHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.addObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.addObserver("ChildEvent.END_DROP",this,__endDropHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("ChildEvent.HIDE_CHANGE",this,__bagItemUpdateHandler);
         MsgMan.removeObserver("ChildEvent.START_DROP",this,__startDropHandler);
         MsgMan.removeObserver("ChildEvent.END_DROP",this,__endDropHandler);
      }
      
      private function __startDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = true;
         _effectBack.movie.play();
      }
      
      private function __endDropHandler(param1:String, param2:Object) : void
      {
         _effectBack.visible = false;
         _effectBack.movie.stop();
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanList();
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_cell);
         _cell = null;
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         super.dispose();
      }
      
      private function cleanList() : void
      {
         if(_list)
         {
            while(_list.length > 0)
            {
               _list.pop().dispose();
            }
            _list = null;
         }
      }
   }
}

