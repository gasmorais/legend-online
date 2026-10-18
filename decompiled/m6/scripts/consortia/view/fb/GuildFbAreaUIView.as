package consortia.view.fb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.module.guildfb.GuildFBAreaNode;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GuildFBDropTempInfo;
   import yishi.datas.templates.GuildFBTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class GuildFbAreaUIView extends Sprite
   {
      
      private var _areaRewardBack:MutipleImage;
      
      private var _bit0:Bitmap;
      
      private var _headIcon:BaseIconView;
      
      private var _areaDesTxt:FilterFrameText;
      
      private var _areaCountTxt:FilterFrameText;
      
      private var _areaHurtCountTxt:FilterFrameText;
      
      private var _areaNameTxt:FilterFrameText;
      
      private var _data:GuildFBAreaNode;
      
      private var _rollPanel:HRollItemPanel;
      
      private var _leadDestxt:FilterFrameText;
      
      public function GuildFbAreaUIView()
      {
         super();
         initView();
      }
      
      public function get data() : GuildFBAreaNode
      {
         return _data;
      }
      
      public function set data(param1:GuildFBAreaNode) : void
      {
         _data = param1;
         if(_data != null)
         {
            refreshView();
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc8_:GoodsInfo = null;
         var _loc5_:GuildFBDropTempInfo = null;
         var _loc7_:int = 0;
         _areaNameTxt.text = _data.leader.nickName;
         _areaCountTxt.text = "" + _data.leader.attackCount;
         _areaHurtCountTxt.text = "" + _data.leader.totalDamage;
         _headIcon.icon = IconFactory.getPlayerIcon(_data.leader.headId,"head");
         var _loc6_:GuildFBTempInfo = TempleteManager.instance.guildFBTempCate.getOneNode(_data.areaId,_data.diff);
         _areaDesTxt.text = LanguageMgr.GetTranslation("guildfb.areaRewardFrame.Des",_loc6_.conciseName);
         var _loc1_:Array = TempleteManager.instance.guildFBDropTempCate.getTempInfos(_loc6_.AreaDropId);
         var _loc4_:int = int(_loc1_.length);
         var _loc3_:Array = [];
         _loc7_ = 0;
         while(_loc7_ < _loc4_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc5_ = _loc1_[_loc7_];
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc5_.ItemId;
            _loc8_.count = _loc5_.Count;
            _loc8_.isBinds = _loc5_.IsBind;
            _loc8_.validDate = _loc5_.ValidDate;
            _loc2_.data = _loc8_;
            _loc3_.push(_loc2_);
            _loc7_++;
         }
         _rollPanel.updateList(_loc3_);
      }
      
      private function initView() : void
      {
         _areaRewardBack = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaRewardBack");
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.guild.area.mvp");
         _headIcon = ComponentFactory.Instance.creatCustomObject("ui.guildfb.headIcon");
         _areaDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaDesTxt");
         _areaCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaCountTxt");
         _areaHurtCountTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaHurtCountTxt");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.areaNameTxt");
         _rollPanel = ComponentFactory.Instance.creatCustomObject("ui.guildfb.areaRewardRollPanel");
         _rollPanel.initParams("ui.guildfb.areaRewardbox","ui.guildfb.areaLeftBtn","ui.guildfb.areaRightBtn",4,60,60,10);
         _leadDestxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.leaddesTxt");
         addChild(_areaRewardBack);
         addChild(_bit0);
         addChild(_headIcon);
         addChild(_areaDesTxt);
         addChild(_areaCountTxt);
         addChild(_areaHurtCountTxt);
         addChild(_areaNameTxt);
         addChild(_leadDestxt);
         addChild(_rollPanel);
         _leadDestxt.text = LanguageMgr.GetTranslation("guildfb.areaLeader");
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_areaRewardBack);
         _areaRewardBack = null;
         ObjectUtils.disposeObject(_rollPanel);
         _rollPanel = null;
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_areaDesTxt);
         _areaDesTxt = null;
         ObjectUtils.disposeObject(_areaCountTxt);
         _areaCountTxt = null;
         ObjectUtils.disposeObject(_areaHurtCountTxt);
         _areaHurtCountTxt = null;
         ObjectUtils.disposeObject(_areaNameTxt);
         _areaNameTxt = null;
         ObjectUtils.disposeObject(_leadDestxt);
         _leadDestxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

