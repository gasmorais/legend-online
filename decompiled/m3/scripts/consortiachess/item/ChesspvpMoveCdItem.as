package consortiachess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.ChessPvpManager;
   import mvc.module.chesspvp.ChesspvpRoleInfo;
   
   public class ChesspvpMoveCdItem extends Sprite
   {
      
      private var _cdTxt:FilterFrameText;
      
      private var _btn:IconButton;
      
      private var _numTxt:FilterFrameText;
      
      private var _info:ChesspvpRoleInfo;
      
      private const REIVER_TIME:int = 3;
      
      public function ChesspvpMoveCdItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _info = ChessPvpManager.Instance.model.selfInfo;
         _cdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bMoveCdTxt");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bMoveBtn");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.chesspvp.bRivernTxt");
         addChild(_cdTxt);
         addChild(_btn);
         addChild(_numTxt);
      }
      
      public function get btn() : IconButton
      {
         return _btn;
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         if(_info)
         {
            _loc1_ = 3 - _info.reiverTime;
            if(_loc1_ < 0)
            {
               _loc1_ = 0;
            }
            _numTxt.text = LanguageMgr.GetTranslation("chesspvp.battle.riverTime",_loc1_,3);
            switch(int(_info.state))
            {
               case 0:
                  this.visible = true;
                  if(_info.waitCd > 0)
                  {
                     _cdTxt.text = LanguageMgr.GetTranslation("chesspvp.battle.moveCd",_info.waitCd);
                     _btn.enable = false;
                  }
                  else
                  {
                     _cdTxt.text = "";
                     _btn.enable = true;
                  }
                  break;
               case 1:
                  this.visible = true;
                  _cdTxt.text = LanguageMgr.GetTranslation("chesspvp.battle.moveTime",_info.currMoveTime);
                  _btn.enable = false;
                  break;
               case 3:
                  this.visible = false;
                  break;
               default:
                  _cdTxt.text = "";
                  _btn.enable = true;
                  this.visible = false;
            }
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_cdTxt);
         _cdTxt = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _info = null;
      }
   }
}

