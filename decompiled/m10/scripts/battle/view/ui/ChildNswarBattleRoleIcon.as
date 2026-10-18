package battle.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pvp.ChildPvpBattleChildMsg;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class ChildNswarBattleRoleIcon extends Sprite
   {
      
      private var _icon:BaseIconView;
      
      private var _bg:Bitmap;
      
      private var _idxBg:Image;
      
      private var _idxTxt:FilterFrameText;
      
      private var _fightIng:Bitmap;
      
      private var _dieImg:Bitmap;
      
      private var _idx:int;
      
      private var _side:int;
      
      private var _mShape:Shape;
      
      public function ChildNswarBattleRoleIcon(param1:int, param2:int)
      {
         super();
         _idx = param1;
         _side = param2;
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.battle.nswarIconBg");
         _icon = ComponentFactory.Instance.creatCustomObject("childnswar.battle.childIcon");
         _dieImg = ComponentFactory.Instance.creatBitmap("asset.battle.nswarDie");
         if(_side == 1)
         {
            _idxBg = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.IdxLeftImg");
            _idxTxt = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.leftIdx");
            _fightIng = ComponentFactory.Instance.creatBitmap("asset.battle.nswarLeft");
         }
         else
         {
            _idxBg = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.IdxRightImg");
            _idxTxt = ComponentFactory.Instance.creatComponentByStylename("battle.childnswar.rightIdx");
            _fightIng = ComponentFactory.Instance.creatBitmap("asset.battle.nswarRight");
         }
         _mShape = new Shape();
         _mShape.graphics.beginFill(16711680);
         _mShape.graphics.drawCircle(0,0,20);
         _mShape.graphics.endFill();
         _mShape.x = 27.5;
         _mShape.y = 30;
         addChild(_bg);
         addChild(_icon);
         addChild(_mShape);
         addChild(_idxBg);
         addChild(_idxTxt);
         addChild(_fightIng);
         addChild(_dieImg);
         _dieImg.visible = false;
         _fightIng.visible = false;
         _icon.mask = _mShape;
         _idxTxt.text = "" + _idx;
      }
      
      public function updateView(param1:ChildPvpBattleChildMsg) : void
      {
         var _loc2_:ChildTempInfo = null;
         if(param1)
         {
            _loc2_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.jobType,1);
            _icon.icon = PathManager.info.ResourcePath + "icon" + _loc2_.Icon;
            _dieImg.visible = false;
            _fightIng.visible = false;
            switch(int(param1.state))
            {
               case 0:
                  break;
               case 1:
                  _fightIng.visible = true;
                  break;
               case 2:
                  _dieImg.visible = true;
            }
         }
         else
         {
            _icon.icon = null;
            _fightIng.visible = false;
            _dieImg.visible = false;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_idxBg);
         _idxBg = null;
         ObjectUtils.disposeObject(_idxTxt);
         _idxTxt = null;
         ObjectUtils.disposeObject(_fightIng);
         _fightIng = null;
         ObjectUtils.disposeObject(_dieImg);
         _dieImg = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

