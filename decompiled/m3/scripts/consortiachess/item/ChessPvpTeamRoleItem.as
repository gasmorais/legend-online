package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.util.ChesspvpResourceUtil;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   
   public class ChessPvpTeamRoleItem extends Sprite
   {
      
      private var _txt:FilterFrameText;
      
      private var _bit:Bitmap;
      
      private var _data:ChesspvpRoleInfo;
      
      private const REIVER_TIME:int = 3;
      
      public function ChessPvpTeamRoleItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.battle.RolenumTxt");
         _bit = new Bitmap();
         addChild(_txt);
         addChild(_bit);
      }
      
      public function set data(param1:ChesspvpRoleInfo) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         if(_data)
         {
            _loc2_ = 3 - _data.reiverTime;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            _txt.text = LanguageMgr.GetTranslation("chesspvp.battle.teamInfo",_data.nikeName,_loc2_,3);
            _bit.bitmapData = ChesspvpResourceUtil.ins.roleDataList[_data.chessType];
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

