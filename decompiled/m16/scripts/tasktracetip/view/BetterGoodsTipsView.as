package tasktracetip.view
{
   import bag.datas.GoodsSonType;
   import bag.helper.GoodsCheck;
   import cell.view.playerequip.PlayerEquipCell;
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.TaskTraceTipManager;
   import tasktracetip.data.TipMessageData;
   import yishi.datas.consant.ArmyPanelEnum;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class BetterGoodsTipsView extends TaskTraceTipView
   {
      
      private var _icon:BaseItemView;
      
      private var _contentTxt:FilterFrameText;
      
      public function BetterGoodsTipsView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _back.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("taskTraceTips.ItemView");
         _icon.iconBack = iconLoadComplete;
         _contentTxt = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.RightContentTxt");
         _textBtn = ComponentFactory.Instance.creatComponentByStylename("taskTraceTips.EquiptBtn");
         _contentTxt.text = LanguageMgr.GetTranslation("tasktracetip.view.BetterGoodsTipsView.tips");
         _textBtn.text = LanguageMgr.GetTranslation("tasktracetip.view.BetterGoodsTipsView.text");
         addChild(_icon);
         addChild(_contentTxt);
         addChild(_textBtn);
      }
      
      override public function set data(param1:TipMessageData) : void
      {
         super.data = param1;
         if(!GoodsCheck.checkGoodsBetterThanHero(_data.goods))
         {
            TaskTraceTipManager.instance.cleanByType(_data.type);
            return;
         }
         _textBtn.enable = false;
         _icon.data = _data.goods;
         _contentTxt.height = _contentTxt.textHeight + _contentTxt.numLines * 4;
         _contentTxt.y = 55 - (_contentTxt.numLines - 1) * 10;
      }
      
      private function iconLoadComplete(param1:BaseItemView = null) : void
      {
         _textBtn.enable = true;
      }
      
      override protected function __btnHandler(param1:Event) : void
      {
         var _loc2_:String = null;
         var _loc4_:Array = null;
         var _loc3_:Array = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc5_:Frame = null;
         var _loc6_:DisplayObject = null;
         var _loc7_:PlayerEquipCell = null;
         var _loc11_:Point = null;
         super.__btnHandler(param1);
         if(!_data || !_data.goods)
         {
            dispose();
            return;
         }
         FrameControllerManager.instance.armyController.model.currentPage = int(_data.goods.pos / 56) + 1;
         var _loc8_:GoodsInfo = GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(_data.goods.id);
         if(_loc8_ == null)
         {
            _loc2_ = LanguageMgr.GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            MessageTipManager.instance().show(_loc2_);
            TaskTraceTipManager.instance.cleanByType(data.type);
            return;
         }
         if(!GoodsCheck.checkGoodsBetterThanHero(_loc8_))
         {
            TaskTraceTipManager.instance.cleanByType(data.type);
            return;
         }
         if(_loc8_)
         {
            _loc4_ = GoodsManager.instance.getHeroGoodsListBySonTypeAndId(_loc8_.templateInfo.SonType,thane.id).getList();
            _loc3_ = GoodsSonType.getSonTypePos(_loc8_.templateInfo.SonType);
            _loc9_ = int(_loc3_[0]);
            _loc10_ = 0;
            if(_loc3_.length > 1)
            {
               if(_loc3_.length > _loc4_.length)
               {
                  _loc9_ = int(_loc3_[_loc4_.length]);
               }
            }
            if(FrameControllerManager.instance.armyController.model.currentOpenPanel == ArmyPanelEnum.EQUIP_PANEL)
            {
               _loc5_ = FrameControllerManager.instance.armyController.frame;
            }
            if(!_loc5_)
            {
               FrameControllerManager.instance.armyController.startFrameByType(ArmyPanelEnum.EQUIP_PANEL,callBack);
            }
            else
            {
               _loc5_ = FrameControllerManager.instance.armyController.frame;
               _loc5_["defaultContent"] = ArmyPanelEnum.EQUIP_PANEL;
               _loc6_ = getDragIconObj(_loc8_);
               _loc7_ = _loc5_["equipView"].getItemViewByPos(_loc9_);
               _loc11_ = _loc7_.parent.localToGlobal(new Point(_loc7_.x,_loc7_.y));
               _loc6_.x = _icon.parent.localToGlobal(new Point(_icon.x,_icon.y)).x;
               _loc6_.y = _icon.parent.localToGlobal(new Point(_icon.x,_icon.y)).y;
               StageReferance.stage.addChild(_loc6_);
               TweenMax.to(_loc6_,2,{
                  "x":_loc11_.x,
                  "y":_loc11_.y,
                  "onComplete":complete,
                  "onCompleteParams":[_loc8_,_loc7_,_loc6_,_loc9_]
               });
               TaskTraceTipManager.instance.cleanByType(data.type);
            }
         }
      }
      
      private function callBack() : void
      {
         var _loc1_:String = null;
         var _loc4_:Array = null;
         var _loc2_:Array = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc7_:GoodsInfo = GoodsManager.instance.getGoodsByGoodsIdFromGeneralBag(_data.goods.id);
         if(_loc7_ == null)
         {
            _loc1_ = LanguageMgr.GetTranslation("tasktracetip.view.BetterGoodsTipsView.command01");
            MessageTipManager.instance().show(_loc1_);
            TaskTraceTipManager.instance.cleanByType(data.type);
            return;
         }
         if(!GoodsCheck.checkGoodsBetterThanHero(_loc7_))
         {
            TaskTraceTipManager.instance.cleanByType(data.type);
            return;
         }
         var _loc3_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc3_)
         {
            _loc3_ = FrameControllerManager.instance.armyController.frame;
            _loc3_["show"]();
         }
         if(_loc7_)
         {
            _loc4_ = GoodsManager.instance.getHeroGoodsListBySonTypeAndId(_loc7_.templateInfo.SonType,thane.id).getList();
            _loc2_ = GoodsSonType.getSonTypePos(_loc7_.templateInfo.SonType);
            _loc8_ = int(_loc2_[0]);
            _loc9_ = 0;
            if(_loc2_.length > 1)
            {
               if(_loc2_.length > _loc4_.length)
               {
                  _loc8_ = int(_loc2_[_loc4_.length]);
               }
            }
         }
         var _loc5_:DisplayObject = getDragIconObj(_loc7_);
         var _loc6_:PlayerEquipCell = _loc3_["equipView"].getItemViewByPos(_loc8_);
         var _loc10_:Point = _loc6_.parent.localToGlobal(new Point(_loc6_.x,_loc6_.y));
         var _loc11_:BaseItemView = _loc3_["equipBag"].getBaseBagItemByPos(_data.goods.pos);
         _loc11_.mouseChildren = _loc11_.mouseEnabled = false;
         _loc5_.x = _icon.parent.localToGlobal(new Point(_icon.x,_icon.y)).x;
         _loc5_.y = _icon.parent.localToGlobal(new Point(_icon.x,_icon.y)).y;
         StageReferance.stage.addChild(_loc5_);
         TweenMax.to(_loc5_,2,{
            "x":_loc10_.x,
            "y":_loc10_.y,
            "onComplete":complete,
            "onCompleteParams":[_loc7_,_loc6_,_loc5_,_loc8_]
         });
         TaskTraceTipManager.instance.cleanByType(data.type);
      }
      
      private function complete(param1:GoodsInfo, param2:PlayerEquipCell, param3:DisplayObject, param4:int) : void
      {
         var _loc6_:BaseItemView = null;
         TweenMax.killTweensOf(param3);
         PlayerManager.instance.moveBagToBag(param1.bagType,param1.objectId,param1.pos,4,thane.id,param4,1);
         ObjectUtils.disposeObject(param3);
         param3 = null;
         param2 = null;
         var _loc5_:Frame = FrameControllerManager.instance.armyController.frame;
         if(_loc5_ && _data)
         {
            _loc6_ = _loc5_["equipBag"].getBaseBagItemByPos(param1.pos);
            _loc6_.mouseChildren = _loc6_.mouseEnabled = true;
         }
      }
      
      public function getDragIconObj(param1:GoodsInfo) : DisplayObject
      {
         var _loc2_:BitmapData = null;
         var _loc4_:Bitmap = null;
         var _loc3_:Sprite = new Sprite();
         var _loc5_:DisplayObject = _icon.icon.content;
         if(param1 && _loc5_)
         {
            _loc2_ = new BitmapData(_loc5_.width / _loc5_.scaleX,_loc5_.height / _loc5_.scaleY,true,0);
            _loc2_.draw(_loc5_);
            _loc4_ = new Bitmap(_loc2_);
            _loc4_.alpha = 1;
            _loc4_.width = 54;
            _loc4_.height = 54;
            _loc3_.addChild(_loc4_);
         }
         return _loc3_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         if(_icon)
         {
            _icon.dispose();
         }
         _icon = null;
         if(_contentTxt)
         {
            _contentTxt.dispose();
         }
         _contentTxt = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

