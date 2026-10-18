package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChessPvpBoardInfo;
   import mvc.module.chesspvp.ChessPvpModel;
   import utils.LogicUtils;
   
   public class ChesspvpTeamInfoItem extends Sprite
   {
      
      private var _teamName:FilterFrameText;
      
      private var _nameBg:Bitmap;
      
      private var _vbox:VBox;
      
      private var _itemList:Array = [];
      
      private var _type:int;
      
      public function ChesspvpTeamInfoItem(param1:int)
      {
         super();
         _type = param1;
         initView();
      }
      
      private function initView() : void
      {
         _nameBg = ComponentFactory.Instance.creatBitmap("asset.chesspvp.battle.team" + _type);
         _teamName = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battle.teamGName");
         _vbox = ComponentFactory.Instance.creatCustomObject("ui.chesspvp.battle.teamVbox");
         addChild(_nameBg);
         addChild(_teamName);
         addChild(_vbox);
         _teamName.text = LanguageMgr.GetTranslation("chesspvp.battle.team" + _type);
         _teamName.setFrame(_type + 1);
      }
      
      public function updateList(param1:Array) : void
      {
         var _loc5_:int = 0;
         var _loc3_:ChessPvpTeamRoleItem = null;
         var _loc6_:int = 0;
         _vbox.removeAllChild();
         _vbox.beginChanges();
         var _loc7_:ChessPvpBoardInfo = model.boradInfo;
         var _loc4_:int = int(param1 ? param1.length : 0);
         var _loc2_:int = int(_itemList.length);
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = int(param1[_loc6_]);
            if(_loc6_ < _loc2_)
            {
               _loc3_ = _itemList[_loc6_];
            }
            else
            {
               _loc3_ = new ChessPvpTeamRoleItem();
               _itemList.push(_loc3_);
            }
            _loc3_.data = _loc7_.roleDic[_loc5_];
            _vbox.addChild(_loc3_);
            _loc6_++;
         }
         _vbox.commitChanges();
      }
      
      private function get model() : ChessPvpModel
      {
         return ChessPvpManager.Instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_nameBg);
         _nameBg = null;
         ObjectUtils.disposeObject(_teamName);
         _teamName = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

