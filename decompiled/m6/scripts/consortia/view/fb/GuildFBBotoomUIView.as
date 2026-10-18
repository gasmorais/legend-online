package consortia.view.fb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.fb.item.GuildFBAreaBoxItem;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBNode;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.MsgMan;
   
   public class GuildFBBotoomUIView extends Sprite
   {
      
      private var _bit4:Bitmap;
      
      private var _itemList:Vector.<GuildFBAreaBoxItem>;
      
      private var _maskShape:Shape;
      
      private const _posList:Array = [[-7,-7],[75,-36],[154,-48],[236,-37],[317,-8]];
      
      private const MAX:int = 5;
      
      public function GuildFBBotoomUIView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("GuildFBModel.areaNode",this,areaNodeChangeHandler);
         MsgMan.addObserver("GuildFBModel.changeDiff",this,areaNodeChangeHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("GuildFBModel.areaNode",this,areaNodeChangeHandler);
         MsgMan.removeObserver("GuildFBModel.changeDiff",this,areaNodeChangeHandler);
      }
      
      private function areaNodeChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function initView() : void
      {
         _bit4 = ComponentFactory.Instance.creatBitmap("asset.guild.botoom.back");
         _maskShape = new Shape();
         _maskShape.graphics.beginFill(65280);
         _maskShape.graphics.drawRect(_bit4.x,_bit4.y,_bit4.width,_bit4.height);
         _maskShape.graphics.endFill();
         addChild(_bit4);
         addChild(_maskShape);
         _bit4.mask = _maskShape;
         initBox();
         refreshView();
      }
      
      private function initBox() : void
      {
         var _loc1_:GuildFBAreaBoxItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<GuildFBAreaBoxItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ui.guildfb.GuildFBAreaBoxItem");
            addChild(_loc1_);
            _loc1_.x = _posList[_loc2_][0];
            _loc1_.y = _posList[_loc2_][1];
            _itemList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function refreshMask(param1:int) : void
      {
         _maskShape.graphics.clear();
         _maskShape.graphics.beginFill(65280);
         _maskShape.graphics.drawRect(_bit4.x,_bit4.y,param1,_bit4.height);
         _maskShape.graphics.endFill();
      }
      
      private function refreshView() : void
      {
         var _loc2_:GuildFBAreaBoxItem = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc11_:Array = null;
         var _loc10_:Array = model.getCurrAreaNodesByDiff();
         var _loc3_:int = int(_loc10_.length);
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc2_ = _itemList[_loc8_];
            _loc2_.setTipParam([_loc8_ + 1,model.currSelectDiff]);
            if(_loc8_ < _loc3_)
            {
               _loc2_.data = _loc10_[_loc8_];
            }
            else
            {
               _loc2_.data = null;
            }
            _loc8_++;
         }
         var _loc5_:int = _loc3_ - 1;
         if(_loc5_ > 0)
         {
            _loc7_ = _loc5_ * 12;
         }
         var _loc1_:int = _loc3_ + 1;
         if(_loc1_ <= 5 && _loc1_ > 1)
         {
            _loc9_ = 0;
            _loc11_ = model.getFightNodeListByDiff(_loc1_,model.currSelectDiff);
            for each(var _loc6_:GuildFBNode in _loc11_)
            {
               if(_loc6_.rewardState != 0)
               {
                  _loc9_++;
               }
            }
            _loc7_ += _loc9_;
         }
         var _loc4_:int = _loc7_ / 48 * _bit4.width;
         refreshMask(_loc4_);
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit4);
         _bit4 = null;
         for each(var _loc1_:GuildFBAreaBoxItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _itemList = null;
         ObjectUtils.disposeObject(_maskShape);
         _maskShape = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

