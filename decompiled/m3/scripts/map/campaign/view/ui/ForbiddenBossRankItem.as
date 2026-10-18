package map.campaign.view.ui
{
   import battle.utils.Int64Utils;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.forbiddenboss.ForbiddenBossRankMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.forbiddenboss.ForbiddenBossModel;
   import yishi.manager.ForbiddenBossManager;
   
   public class ForbiddenBossRankItem extends Sprite implements Disposeable
   {
      
      private var _rankImg:ScaleFrameImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _nickNameTxt:FilterFrameText;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _percentTxt:FilterFrameText;
      
      private var _line:Bitmap;
      
      public function ForbiddenBossRankItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _rankImg = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossRankItem.rankImg");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossRankItem.rankTxt");
         _nickNameTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossRankItem.nickNameTxt");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossRankItem.consortiaNameTxt");
         _percentTxt = ComponentFactory.Instance.creatComponentByStylename("forbiddenBossRankItem.percentTxt");
         _line = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.line");
         addChild(_rankImg);
         addChild(_rankTxt);
         addChild(_nickNameTxt);
         addChild(_consortiaNameTxt);
         addChild(_percentTxt);
         addChild(_line);
         _line.x = 10;
         _line.y = 45;
      }
      
      public function set data(param1:ForbiddenBossRankMsg) : void
      {
         if(param1.rank <= 3)
         {
            _rankImg.visible = true;
            _rankTxt.text = "";
            _rankImg.setFrame(param1.rank);
         }
         else
         {
            _rankImg.visible = false;
            _rankTxt.text = param1.rank.toString();
         }
         _nickNameTxt.text = param1.nickName;
         if(param1.consortiaName != "")
         {
            _consortiaNameTxt.text = LanguageMgr.GetTranslation("forbiddenBossRankItem.consortiaNameTxt.text",param1.consortiaName);
         }
         else
         {
            _consortiaNameTxt.text = "";
         }
         var _loc2_:Number = Int64Utils.int64ToNumber(param1.damage) / model.maxHp * 100;
         _percentTxt.text = LanguageMgr.GetTranslation("assaultwar.AssaultwarStartFrame.frameTxt01",_loc2_.toFixed(2));
      }
      
      private function get model() : ForbiddenBossModel
      {
         return ForbiddenBossManager.instance.model;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

