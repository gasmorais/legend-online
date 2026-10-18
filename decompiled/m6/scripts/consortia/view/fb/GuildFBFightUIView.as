package consortia.view.fb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import mvc.controler.GuildFbController;
   import mvc.module.guildfb.GuildFBNode;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GuildFBDropTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   
   public class GuildFBFightUIView extends Sprite
   {
      
      private var _fightBack:MutipleImage;
      
      private var _fightBtn:BaseButton;
      
      private var _bit7:Bitmap;
      
      private var _fightTimeDesTxt:FilterFrameText;
      
      private var _bossHp:ProgressPanel;
      
      private var _rewardbox:HBox;
      
      private var _buffBox:HBox;
      
      private var _data:GuildFBNode;
      
      public function GuildFBFightUIView()
      {
         super();
         initView();
      }
      
      public function get data() : GuildFBNode
      {
         return _data;
      }
      
      public function get fightBtn() : BaseButton
      {
         return _fightBtn;
      }
      
      public function setData(param1:GuildFBNode, param2:Boolean = false) : void
      {
         _data = param1;
         if(_data != null)
         {
            if(param2 && _data.rewardState == 3)
            {
               control.requestOp(1,_data.nodeID);
            }
            refreshView();
         }
      }
      
      private function get control() : GuildFbController
      {
         return FrameControllerManager.instance.guildFbController;
      }
      
      private function initView() : void
      {
         _fightBack = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.fightBack");
         _fightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.fightBtn");
         _bit7 = ComponentFactory.Instance.creatBitmap("asset.guild.fight.flg");
         _fightTimeDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.fightTimeDesTxt");
         _rewardbox = ComponentFactory.Instance.creatCustomObject("ui.guildfb.fightRWbox");
         _buffBox = ComponentFactory.Instance.creatCustomObject("ui.guildfb.fightBuffbox");
         _bossHp = ComponentFactory.Instance.creatCustomObject("ui.guildfb.bossHp");
         _bossHp.initView("asset.guild.fight.pback","asset.guild.fight.pbar","ui.guildfb.bossHpTxt");
         addChild(_fightBack);
         addChild(_buffBox);
         addChild(_fightBtn);
         addChild(_bit7);
         addChild(_fightTimeDesTxt);
         addChild(_rewardbox);
         addChild(_bossHp);
      }
      
      private function refreshBuff() : void
      {
         var _loc2_:BaseIconView = null;
         var _loc3_:SkillTempInfo = null;
         if(_buffBox.numChildren > 0)
         {
            return;
         }
         ObjectUtils.removeChildAllChildren(_buffBox);
         _buffBox.beginChanges();
         for each(var _loc1_:int in _data.buffID)
         {
            _loc3_ = TempleteManager.instance.getSkillTemplateInfoById(_loc1_);
            if(_loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("ui.guildfb.buffIcon");
               _loc2_.icon = IconFactory.getTecIconByIcon(_loc3_.Icons);
               _loc2_.tipData = _loc1_;
               _buffBox.addChild(_loc2_);
            }
         }
         _buffBox.commitChanges();
      }
      
      private function refreshRewards() : void
      {
         var _loc2_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:GuildFBDropTempInfo = null;
         var _loc5_:int = 0;
         if(_rewardbox.numChildren > 0)
         {
            return;
         }
         var _loc1_:Array = TempleteManager.instance.guildFBDropTempCate.getTempInfos(_data.currTempInfo.NodeDropId);
         var _loc3_:int = int(_loc1_.length);
         _rewardbox.beginChanges();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc5_];
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _loc4_.ItemId;
            _loc6_.count = _loc4_.Count;
            _loc6_.isBinds = _loc4_.IsBind;
            _loc6_.validDate = _loc4_.ValidDate;
            _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _loc2_.data = _loc6_;
            _rewardbox.addChild(_loc2_);
            _loc5_++;
         }
         _rewardbox.commitChanges();
      }
      
      private function refreshBossHp() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(_data.rewardState == 3)
         {
            _loc1_ = _data.bossMaxHp - _data.bossHp;
            _bossHp.progressValue(_loc1_,_data.bossMaxHp);
            _loc2_ = _loc1_ / _data.bossMaxHp * 100;
            _bossHp.setValueText(_loc2_ + "%");
         }
         else
         {
            _bossHp.progressValue(1,1);
            _bossHp.setValueText("100%");
         }
      }
      
      private function refreshView() : void
      {
         refreshBuff();
         refreshRewards();
         refreshBossHp();
         _fightBtn.visible = _data.rewardState == 3;
         _bit7.visible = _data.rewardState != 3;
         _fightTimeDesTxt.text = LanguageMgr.GetTranslation("guildfb.fightNode.attackNum",_data.attackCount);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_fightBack);
         _fightBack = null;
         ObjectUtils.disposeObject(_buffBox);
         _buffBox = null;
         ObjectUtils.disposeObject(_fightBtn);
         _fightBtn = null;
         ObjectUtils.disposeObject(_bit7);
         _bit7 = null;
         ObjectUtils.disposeObject(_bossHp);
         _bossHp = null;
         ObjectUtils.disposeObject(_fightTimeDesTxt);
         _fightTimeDesTxt = null;
         ObjectUtils.disposeObject(_rewardbox);
         _rewardbox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

